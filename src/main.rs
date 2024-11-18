use alfred::Item;
use anyhow::Result;
use clap::{Parser, Subcommand};
use github::Repo;
use serde::{Deserialize, Serialize, Serializer};
use serde_json::json;

mod alfred;
mod github;

#[derive(Serialize)]
struct Output {
    name: String,
}

#[derive(Subcommand, Serialize, Debug)]
enum Commands {
    Repos {},
}

#[derive(Parser, Debug)]
struct Cli {
    #[command(subcommand)]
    command: Option<Commands>,
    #[arg(long)]
    token: String,
}

async fn handle(cli: Cli) -> Result<()> {
    if let Some(cmd) = &cli.command {
        match cmd {
            Commands::Repos {} => {
                let url = "https://api.github.com/user/repos?per_page=100";
                let client = reqwest::Client::new();

                let auth_header = format!("Bearer {}", cli.token);
                println!("{}", auth_header);

                let result = client
                    .get(url)
                    .header("Authorization", auth_header)
                    .header("Content-Type", "application/json")
                    .header("User-Agent", "Alfred Workflow")
                    .send()
                    .await?;

                let repos: Vec<Repo> = result.json().await?;
                let items: Vec<Item> = repos.iter().map(|repo| repo.into()).collect();
                let items = serde_json::to_value(items).unwrap();
                let output = json!({
                  "items": items
                });

                println!("{}", output.to_string());
            }
        }
    }

    Ok(())
}

#[tokio::main]
async fn main() {
    let cli = Cli::parse();
    match handle(cli).await {
        Ok(_) => {}
        Err(_) => {}
    }
}
