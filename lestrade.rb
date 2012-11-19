require 'sinatra'
require 'rack-ssl-enforcer'
require_relative 'lib/iap_validator'
require_relative 'lib/metrics'

configure :production do
  require 'newrelic_rpm'

  use Rack::SslEnforcer

  use Rack::Auth::Basic do |username, password|
    [username, password] == [ENV['LESTRADE_USERNAME'], ENV['LESTRADE_PASSWORD']]
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

after do
  Lestrade::Metrics.send_metric({
    route:          request.path,
    user_agent:     request.user_agent,
    content_length: request.content_length,
    request_method: request.request_method,
    client_ip:      request.ip,
    client_version: lib_version,
    status:         response.status,
    response:       response.body
  })
end
