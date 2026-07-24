use uuid::Uuid;

pub mod auth;

#[derive(Debug, Clone)]
pub struct User {
    pub id: Uuid,
    pub username: String,
    pub role: UserRole,
}

#[derive(Debug, Clone, PartialEq)]
pub enum UserRole {
    Admin,
    Manager,
    Viewer,
}

impl UserRole {
    pub fn can_manage(&self) -> bool {
        matches!(self, UserRole::Admin | UserRole::Manager)
    }

    pub fn is_admin(&self) -> bool {
        matches!(self, UserRole::Admin)
    }
}
