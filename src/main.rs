use anyhow::Result;
use clap::{Parser, Subcommand};
use serde::{Deserialize, Serialize};

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

#[derive(Deserialize, Debug)]
struct Repo {
    full_name: String,
    html_url: String,
    private: bool,
    description: Option<String>,
}

async fn handle(cli: Cli) -> Result<()> {
    if let Some(cmd) = &cli.command {
        match cmd {
            Commands::Repos {} => {
                let output = Output {
                    name: "Me".to_string(),
                };
                let url = "https://api.github.com/user/repos?per_page=100";
                let output = serde_json::to_string(&output).unwrap();
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

                let body: Vec<Repo> = result.json().await?;

                println!("{:?}", body);

                // println!("{}", output);
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
