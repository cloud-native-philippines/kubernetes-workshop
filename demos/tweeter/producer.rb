#!/usr/bin/env ruby

require 'faraday'
require 'forgery'
require 'literate_randomizer'
require 'json'

TWEETER_API_URL = ENV['TWEETER_API_URL'] || 'http://localhost:3000'

MIN_SLEEP_TIME = [0, (ENV['MIN_SLEEP_TIME'] || 3).to_i].max
MAX_SLEEP_TIME = [MIN_SLEEP_TIME, (ENV['MAX_SLEEP_TIME'] || 30).to_i].max
SLEEP_RANGE = (MAX_SLEEP_TIME - MIN_SLEEP_TIME) * 1000 + 1


handle = Forgery('internet').user_name

client = Faraday.new(url: TWEETER_API_URL,
                     headers: {'Content-Type' => 'application/json'})

loop do
  body = {
    handle: handle,
    content: LiterateRandomizer.sentence
  }

  client.post '/tweets', body.to_json

  ms = MIN_SLEEP_TIME * 1000 + Random.rand(SLEEP_RANGE)
  puts "#{Time.now.strftime('%H:%M:%S')} Sleeping for #{ms} ms"
  sleep ms / 1000.0
end
