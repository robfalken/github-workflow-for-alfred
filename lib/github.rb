# frozen_string_literal: true

require "net/http"

# A simple class that makes authenticated API calls to Github
class Github
  def initialize(token)
    @token = token
  end

  def api_call(endpoint)
    uri = URI(endpoint)
    req = Net::HTTP::Get.new(uri)
    req["Authorization"] = "Bearer #{@token}"

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(req)
    end

    JSON.parse(response.body)
  end
end
