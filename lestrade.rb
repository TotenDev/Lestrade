require 'sinatra'
require 'rack-ssl-enforcer'
require_relative 'lib/iap_validator'

use Rack::SslEnforcer

use Rack::Auth::Basic do |username, password|
  [username, password] == [ENV['LESTRADE_USERNAME'], ENV['LESTRADE_PASSWORD']]
end

post '/validate' do
  content_type :json
  data = JSON.parse( request.body.read )
  validate( data['receipt-data'] ).to_json
end

post '/sandbox/validate' do
  content_type :json
  data = JSON.parse( request.body.read )
  validate( data['receipt-data'], true ).to_json
end

def validate( receipt, sandbox=false )
  { status: Lestrade::IAPValidator.valid?( receipt, sandbox ) }
end
