pub mod migrate;

use clap::{Parser, Subcommand};

#[derive(Parser)]
#[command(name = "flustra", version, about = "Your media, your way")]
pub struct Cli {
    #[command(subcommand)]
    pub command: Option<Commands>,
}

#[derive(Subcommand)]
pub enum Commands {
    #[command(about = "Run the Flustra server (default)")]
    Serve,
    #[command(about = "Database operations")]
    Db(DbArgs),
    #[command(about = "Show cluster health information")]
    ClusterHealth,
}

#[derive(clap::Args)]
pub struct DbArgs {
    #[command(subcommand)]
    pub command: DbCommands,
}

#[derive(Subcommand)]
pub enum DbCommands {
    #[command(about = "Migrate data from SQLite to PostgreSQL")]
    Migrate {
        #[arg(
            long,
            default_value = "sqlite://data/flustra.db",
            help = "Source SQLite database URL"
        )]
        from: String,
        #[arg(long, help = "Target PostgreSQL database URL")]
        to: String,
    },
}
