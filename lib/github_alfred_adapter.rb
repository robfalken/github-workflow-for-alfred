# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength

# GithubAlfredAdapter is a class that adapts Github respones to Alfred items
class GithubAlfredAdapter # rubocop:disable Metrics/ClassLength
  class Action
    CLIPBOARD = "clipboard"
    BROWSER = "browser"
    API = "api"
  end

  class Icon
    COMMIT = { path: "icons/commit.svg" }.freeze
    DIFF = { path: "icons/diff.svg" }.freeze
    ISSUE = { path: "icons/issue.svg" }.freeze
    PR = { path: "icons/pull-request.svg" }.freeze
    REPO = { path: "icons/repo.svg" }.freeze
    FILE = { path: "icons/file.svg" }.freeze
    CLIPBOARD = { path: "icons/clipboard.svg" }.freeze
  end

  class << self # rubocop:disable Metrics/ClassLength
    def issues(issue)
      browser_url = issue["html_url"]
      id = issue["id"]
      title = issue["title"]
      number = issue["number"]
      user = issue["user"]["login"]
      title = "#{title} (##{number})"
      subtitle = "by #{user}"

      {
        uid: id,
        title: title,
        subtitle: subtitle,
        arg: browser_url,
        quicklookurl: browser_url,
        variables: {
          action: Action::BROWSER,
        },
        icon: Icon::ISSUE,
      }
    end

    def files(file)
      sha = file["sha"]
      filename = file["filename"]
      browser_url = file["blob_url"]
      title = "#{filename.split("/").last} #{file["status"]}"

      {
        uid: sha,
        title: title,
        subtitle: filename,
        arg: browser_url,
        quicklookurl: browser_url,
        variables: {
          action: Action::BROWSER,
        },
        icon: Icon::FILE,
      }
    end

    def commits(commit) # rubocop:disable Metrics/MethodLength
      sha = commit["sha"]
      message = commit["commit"]["message"]
      subtitle = "#{commit["sha"]} by #{commit["author"]["login"]}"
      browser_url = commit["html_url"]

      {
        uid: sha,
        title: message,
        subtitle: subtitle,
        arg: browser_url,
        quicklookurl: browser_url,
        variables: {
          action: Action::BROWSER,
        },
        icon: Icon::COMMIT,
        mods: {
          ctrl: {
            arg: sha,
            variables: {
              action: Action::CLIPBOARD,
            },
            subtitle: "Copy commit sha to clipboard: #{sha}",
            icon: Icon::CLIPBOARD,
          },
        },
      }
    end

    def pulls(pull) # rubocop:disable Metrics/MethodLength
      id = pull["id"]
      number_and_name = "#{pull["title"]} (#{num_with_hashtag(pull)})"
      subtitle = "#{pull["head"]["ref"]} by #{pull["user"]["login"]}"
      browser_url = pull["html_url"]
      api_url = pull["url"]

      {
        uid: id,
        title: number_and_name,
        subtitle: subtitle,
        arg: browser_url,
        quicklookurl: browser_url,
        variables: {
          action: Action::BROWSER,
        },
        icon: Icon::PR,
        mods: {
          ctrl: {
            arg: num_with_hashtag(pull),
            subtitle: "Copy PR number to clipboard: #{num_with_hashtag(pull)}",
            variables: {
              action: Action::CLIPBOARD,
            },
            icon: Icon::CLIPBOARD,
          },
          alt: {
            arg: "#{browser_url}/commits",
            subtitle: "Go to commits for #{num_with_hashtag(pull)} in the browser",
            variables: {
              action: Action::BROWSER,
            },
            icon: Icon::COMMIT,
          },
          cmd: {
            arg: "#{browser_url}/files",
            subtitle: "Go to diff for #{num_with_hashtag(pull)} in the browser",
            variables: {
              action: Action::BROWSER,
            },
            icon: Icon::DIFF,
          },
          "shift+alt" => {
            arg: "#{api_url}/commits",
            subtitle: "List commits in #{num_with_hashtag(pull)} in Alfred",
            variables: {
              action: Action::API,
            },
            icon: Icon::COMMIT,
          },
          "shift+cmd" => {
            arg: "#{api_url}/files",
            variables: {
              action: Action::API,
            },
            subtitle: "List files in #{num_with_hashtag(pull)} in Alfred",
            icon: Icon::DIFF,
          },
        },
      }
    end

    def repos(repo)
      full_name = repo["full_name"]
      name = repo["name"]
      browser_url = repo["html_url"]
      api_url = repo["url"]

      {
        uid: full_name,
        title: full_name,
        subtitle: repo["description"] || full_name,
        arg: browser_url,
        autocomplete: full_name,
        match: full_name.gsub("/", " "),
        quicklookurl: browser_url,
        variables: {
          action: Action::BROWSER,
        },
        icon: Icon::REPO,
        mods: {
          alt: {
            arg: "#{browser_url}/issues",
            subtitle: "Go to issues for #{name} in the browser",
            variables: {
              action: Action::BROWSER,
            },
            icon: Icon::ISSUE,
          },
          cmd: {
            arg: "#{browser_url}/pulls",
            subtitle: "Go to pull requests for #{name} in the browser",
            variables: {
              action: Action::BROWSER,
            },
            icon: Icon::PR,
          },
          "shift+alt": {
            arg: "#{api_url}/issues",
            subtitle: "List issues for #{name} in Alfred",
            variables: {
              action: Action::API,
            },
            icon: Icon::ISSUE,
          },
          "shift+cmd": {
            arg: "#{api_url}/pulls",
            subtitle: "List pull requests for #{name} in Alfred",
            variables: {
              action: Action::API,
            },
            icon: Icon::PR,
          },
        },
      }
    end

    private

    def num_with_hashtag(pull)
      "##{pull["number"]}"
    end
  end
end

# rubocop:enable Metrics/MethodLength
