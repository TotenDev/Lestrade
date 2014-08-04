require 'sinatra'
require_relative 'lib/iap_validator'

configure :production do
  if ENV['LESTRADE_SHOULD_USE_NEW_RELIC']
    require 'newrelic_rpm'
  end

  if ENV['LESTRADE_SHOULD_USE_SSL']
    require 'rack-ssl-enforcer'
    use Rack::SslEnforcer
  end

  if ENV['LESTRADE_SHOULD_USE_BASIC_AUTH']
    use Rack::Auth::Basic do |username, password|
      [username, password] == [ENV['LESTRADE_BASIC_AUTH_USERNAME'], ENV['LESTRADE_BASIC_AUTH_PASSWORD']]
    end
  end
end

helpers do
  def validate( receipt, sandbox=false )
    { status: Lestrade::IAPValidator.valid?( receipt, sandbox ) }
  end

  def lib_version
    request.env['HTTP_X_LIBLESTRADE_VERSION']
  end
end

not_found do
  'Four, Oh Four.'
end

get '/' do
  'Welcome to Inspector Lestrade!'
end

post '/validate' do
  content_type :json
  data = JSON.parse( request.body.read )
  body validate( data['receipt-data'] ).to_json
end

post '/sandbox/validate' do
  content_type :json
  data = JSON.parse( request.body.read )
  body validate( data['receipt-data'], true ).to_json
end

