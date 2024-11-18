use serde::Serialize;

#[derive(Debug, Serialize)]
pub struct Item {
    pub uid: String,
    pub title: String,
    // pub description: Option<String>,
}

//   uid: sha,
//   title: title,
//   subtitle: filename,
//   arg: browser_url,
//   quicklookurl: browser_url,
//   variables: {
//     action: Action::BROWSER,
//   },
//   mods: BASE_MODS.merge({
//     ctrl: {
//       arg: filename,
//       subtitle: "Copy to clipboard: #{filename}",
//       variables: {
//         action: Action::CLIPBOARD,
//       },
//       icon: Icon::CLIPBOARD,
//     },
//   }),
//   icon: Icon::FILE,
