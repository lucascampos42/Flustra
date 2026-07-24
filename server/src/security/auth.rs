use hmac::{Hmac, Mac};
use sha2::Sha256;
use tracing::warn;
use uuid::Uuid;

use crate::config::SecurityConfig;
use crate::security::{User, UserRole};

type HmacSha256 = Hmac<Sha256>;

pub struct JwtAuth {
    key: Vec<u8>,
    expiry_secs: u64,
}

#[derive(serde::Serialize, serde::Deserialize)]
struct JwtClaims {
    sub: String,
    role: String,
    exp: u64,
    iat: u64,
}

impl JwtAuth {
    pub fn new(config: &SecurityConfig) -> Self {
        Self {
            key: config.jwt_secret.as_bytes().to_vec(),
            expiry_secs: config.token_expiry_secs,
        }
    }

    pub fn issue_token(&self, user: &User) -> anyhow::Result<String> {
        let now = std::time::SystemTime::now()
            .duration_since(std::time::UNIX_EPOCH)
            .unwrap()
            .as_secs();

        let claims = JwtClaims {
            sub: user.id.to_string(),
            role: format!("{:?}", user.role),
            exp: now + self.expiry_secs,
            iat: now,
        };

        let payload = serde_json::to_string(&claims)?;
        let encoded = base64_encode(payload.as_bytes());

        let mut mac = HmacSha256::new_from_slice(&self.key)
            .map_err(|e| anyhow::anyhow!("HMAC key error: {}", e))?;

        let header = base64_encode(r#"{"alg":"HS256","typ":"JWT"}"#.as_bytes());
        let signing_input = format!("{}.{}", header, encoded);
        mac.update(signing_input.as_bytes());

        let signature = base64_encode(&mac.finalize().into_bytes());

        Ok(format!("{}.{}.{}", header, encoded, signature))
    }

    pub fn validate_token(&self, token: &str) -> Option<User> {
        let parts: Vec<&str> = token.split('.').collect();
        if parts.len() != 3 {
            warn!("invalid JWT format");
            return None;
        }

        let signing_input = format!("{}.{}", parts[0], parts[1]);

        let mut mac = HmacSha256::new_from_slice(&self.key).ok()?;
        mac.update(signing_input.as_bytes());

        let expected_sig = base64_encode(&mac.finalize().into_bytes());
        if parts[2] != expected_sig {
            warn!("JWT signature mismatch");
            return None;
        }

        let payload = base64_decode(parts[1])?;

        let claims: JwtClaims = serde_json::from_slice(&payload).ok()?;
        let now = std::time::SystemTime::now()
            .duration_since(std::time::UNIX_EPOCH)
            .unwrap()
            .as_secs();

        if claims.exp < now {
            warn!("JWT expired");
            return None;
        }

        Some(User {
            id: Uuid::parse_str(&claims.sub).ok()?,
            username: claims.sub,
            role: match claims.role.as_str() {
                "Admin" => UserRole::Admin,
                "Manager" => UserRole::Manager,
                _ => UserRole::Viewer,
            },
        })
    }
}

fn base64_encode(data: &[u8]) -> String {
    use base64::Engine;
    base64::engine::general_purpose::URL_SAFE_NO_PAD.encode(data)
}

fn base64_decode(data: &str) -> Option<Vec<u8>> {
    use base64::Engine;
    base64::engine::general_purpose::URL_SAFE_NO_PAD
        .decode(data)
        .ok()
}
