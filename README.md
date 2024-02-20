# GitHub workflow for Alfred 5

<p align="center">
  <img src="https://github.com/robfalken/github-workflow-for-alfred/assets/261929/462538ce-eca9-4cbb-bc67-8b16ba196eba" />
</p>

## Features

* List repositories
* Caching repositories (repo) locally for faster listing
* List pull requests (PR) for repositories
* List issues for a repo
* List diff/files for a PR
* List commits for PR
* Copy commit SHA to clipboard
* Copy PR number to clipboard
* Browse to any item listed above on GitHub

## Installation
TODO: Provide download instructions

### Configuration
The only configuration needed is to provide a personal access token with access to read your repos.

## Usage
The `gh` keyword will list your repos from cache, if it exists.  
If there is no cache, repositories will be fetched from GitHub and cached for later.

To refresh the cache with an updated list of repos from GitHub, use `gh refresh`

### General principles
Holding `Cmd` and `Opt` will alter the behaviour to list items related to the current item instead of viewing the actual item.

For instance, holding `Cmd` for a repo will alter the behaviour to viewing PRs in the repo, rather than browsing the repo itself on [github.com](https://github.com), while holding `Opt` will browse to issues in the repo.

Simultaneously holding down `Shift` will list related items in Alfred instead of launching the browser. So, pressing `Return` while holding `Shift+Cmd` will fetch a list of pull requests for the repo and list them in Alfred

Holding down `Ctrl`, on the other hand, will copy the most suitable representation of the current item to the clipboard. For instance, holding `Ctrl` while selecting a commit, will copy the commit SHA to the clipboard.

When pressing the modifier keys, the icon and description will change to describe the new behavour to make it easier to discover features.

### Full reference
#### Repositories
* `Return` opens a browser window with the repo on GitHub
* `Ctrl+Return` copies `organization/repository` to clipboard
* `Cmd+Return` opens a browser window with the repos pull requests on GitHub
* `Opt+Return` opens a browser window with the repos issues on GitHub
* `Cmd+Shift+Return` list the repos pull requests in Alfred
* `Opt+Shift+Return` list the repos issues in Alfred

#### Pull requests
* `Return` opens a browser window with the PR on GitHub
* `Ctrl+Return` copies the PR number to clipboard
* `Cmd+Return` opens a browser window with the PR diff on GitHub
* `Opt+Return` opens a browser window with the PR commits on GitHub
* `Cmd+Shift+Return` list the PR changed files in Alfred
* `Opt+Shift+Return` list the PR commits in Alfred

#### Issues
* `Return` opens a browser window with the issue on GitHub
* `Ctrl+Return` copies the issue number to clipboard

#### Commits
* `Return` opens a browser window with the commit on GitHub
* `Ctrl+Return` copies the commit SHA to clipboard

#### Files
* `Return` opens a browser window with the file on GitHub
* `Ctrl+Return` copies the file path to clipboard

### Example workflow
* Type `gh` and then search for your repository
* Hold `Shift + Cmd` while pressing `Return` to list **open pull requests** for your repository
* Search for a PR
* Hold `Shift + Alt` while pressing `Return` to list **commits** in the PR
* To perform an action
  * _either_ press `Return` to **browse to the commit** on GitHub
  * _or_ hold `Ctrl` while pressing `Return` to copy the **commit SHA** to clipboard

## Demo

![screencast](https://github.com/robfalken/github-workflow-for-alfred/assets/261929/ff129b9d-8147-4cb1-bbc6-a07fd111265a)
