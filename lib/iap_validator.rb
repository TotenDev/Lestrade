require 'httparty'
require 'json'

module Lestrade
  class IAPValidator
    include HTTParty

    SANDBOX_URL    = 'https://sandbox.itunes.apple.com'
    PRODUCTION_URL = 'https://buy.itunes.apple.com'

    base_uri PRODUCTION_URL
    headers 'Content-Type' => 'application/json'
    format :json

    def self.valid?( receipt, sandbox = false )
      base_uri SANDBOX_URL if sandbox

      res = post( '/verifyReceipt', body: { 'receipt-data' => receipt }.to_json )
      return false unless res.code == 200

      dec = JSON.parse res.body
      return false if dec.nil?

      dec[:status] == 0
    end
  end
end
