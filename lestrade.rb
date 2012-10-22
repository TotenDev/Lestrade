require 'sinatra'
require './lib/iap_validator'
require 'rack-ssl-enforcer'

use Rack::SslEnforcer

use Rack::Auth::Basic do |username, password|
  [username, password] == [ENV['LESTRADE_USERNAME'], ENV['LESTRADE_PASSWORD']]
end

post '/validate' do
  content_type :json
  sandbox = !params[:sandbox].nil?
  receipt = params[:receipt]
  { status: Lestrade::IAPValidator.valid?( receipt, sandbox ) }.to_json
end
