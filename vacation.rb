require "octokit"
require "json"

begin
  ACCESS_TOKEN = ENV.fetch("GITHUB_TOKEN")
  API_ENDPOINT = ENV.fetch("GITHUB_API_ENDPOINT")
rescue KeyError
  $stderr.puts "To run this script, please set the following environment variables:"
  $stderr.puts "- GITHUB_TOKEN: A valid personal access token with Organzation admin priviliges"
  $stderr.puts "- GITHUB_API_ENDPOINT: A valid GitHub/GitHub Enterprise API endpoint URL"
  $stderr.puts "                       (use http://api.github.com for GitHub.com auditing)"
  exit 1
end

Octokit.configure do |kit|
  kit.api_endpoint = API_ENDPOINT
  kit.access_token = ACCESS_TOKEN
  kit.auto_paginate = true
end

@client = Octokit::Client.new

def export
  # Fetch subscriptions
  repos = []
  @client.subscriptions.each do |repo|
    subscription = @client.subscription(repo.full_name)
    repos << { 
      "full_name": repo.full_name, 
      "ignored": subscription.ignored, 
      "subscribed": subscription.subscribed 
    }
  end

  # Write to Vacationfile
  data = { "subscriptions": repos }
  f = File.open("Vacationfile", "w")
  f.write(JSON.pretty_generate(data))
  f.close

  # Ignore repositories
  repos.each do |repo|
    @client.update_subscription(repo[:full_name], {
      "subscribed": false,
      "ignored": true
    })
  end
end

def import
  # Read from Vacationfile
  raw = File.open("Vacationfile", "r").read
  json = JSON.parse(raw)

  # Resubscribe repositories
  json["subscriptions"].each do |repo|
    @client.update_subscription(repo["full_name"], {
      "subscribed": repo["subscribed"],
      "ignored": repo["ignored"]
    })
  end
end

puts @client.rate_limit

# export
import
