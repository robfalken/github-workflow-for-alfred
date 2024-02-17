# frozen_string_literal: true

$LOAD_PATH.unshift "#{File.dirname(__FILE__)}/lib"

require "json"
require "github"
require "github_alfred_adapter"
require "cache"

# Main workflow class
class Workflow
  def initialize
    @args = ARGV.map(&:strip).reject(&:empty?)
    @action = @args[0] || "repos"
    github_token = ENV.fetch("TOKEN")
    @github = Github.new(github_token)
    @cache = Cache.new
  end

  def silent_operation?
    @action == "refresh"
  end

  def run
    send(@action)
  end

  def refresh
    @cache.clear
    repos
  end

  def api_call
    endpoint = @args[1]
    return repos if endpoint.nil?

    result = @github.api_call(endpoint)
    item_type = endpoint.split("?")[0].split("/").last
    items = result.map(&GithubAlfredAdapter.method(item_type))

    puts JSON.dump({ items: items })
  end

  def repos
    return puts(@cache.read) if @cache.exist?

    repos = @github.api_call("https://api.github.com/user/repos?per_page=100")
    items = repos.map(&GithubAlfredAdapter.method(:repos))
    output = JSON.dump({ items: items })

    @cache.write(output)

    puts output unless silent_operation?
  end
end

workflow = Workflow.new
workflow.run
