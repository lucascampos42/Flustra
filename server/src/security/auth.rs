use tracing::warn;

pub struct JwtAuth {
    _secret: Vec<u8>,
    _expiry_secs: u64,
}

impl JwtAuth {
    pub fn new(secret: &str, expiry_secs: u64) -> Self {
        Self {
            _secret: secret.as_bytes().to_vec(),
            _expiry_secs: expiry_secs,
        }
    }

    pub fn validate_token(&self, _token: &str) -> Option<crate::security::User> {
        warn!("JWT validation not yet implemented");
        None
    }
}
