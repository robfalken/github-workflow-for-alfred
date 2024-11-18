use serde::Deserialize;

use crate::alfred::Item;

#[derive(Deserialize, Debug)]
pub struct Repo {
    pub full_name: String,
    pub html_url: String,
    pub private: bool,
    pub description: Option<String>,
}

impl Into<Item> for &Repo {
    fn into(self) -> Item {
        Item {
            uid: self.full_name.to_string(),
            title: self.full_name.to_string(),
            // description: self.description,
        }
    }
}
