require 'sinatra'
require 'json'

use Rack::Auth::Basic do |username, password|
  [username, password] == [ENV['LESTRADE_USERNAME'], ENV['LESTRADE_PASSWORD']]
end

get '/' do
  content_type :json
  { status: "welcome" }.to_json
end
