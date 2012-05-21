require 'omniauth-oauth2'
require 'multi_json'

module OmniAuth
  module Strategies
    class Underskog < OmniAuth::Strategies::OAuth2

      USERINFO_ENDPOINT = 'https://localhost/api/v1/users/current'

      option :name, "underskog"

      # TODO: make this support HTTPS when bug in Origo /-/site/check_mastersession
      # is resolved. See README.md
      option :client_options, {
        :site => 'https://localhost',
        :token_url => '/oauth/token',
        :authorize_url => '/oauth/authorize'
      }

      uid { raw_info['uid'].to_s } # to_s to keep all values as strings

      info do
        raw_info['info']
      end

      extra do
        { 'extra' => raw_info['extra'], 'raw_info' => raw_info }
      end

      def raw_info
        @raw_info ||= access_token.get(USERINFO_ENDPOINT).parsed
        {
          'provider' => 'underskog',
          'uid' => @raw_info['id'],
          'info' => {
            'name' => @raw_info['realname'],
            'first_name' => nil,
            'last_name' => nil,
            'email' => @raw_info['email'],
            'nickname' => @raw_info['name'],
            'location' => nil,
            'description' => @raw_info['description'],
            'image' => 'http://underskog.no'+@raw_info['image_url'],
            'phone' => nil,
            'urls' => {'Underskog' => "http://underskog.no/medlem/vis/#{@raw_info['name']}"}.
              merge(@raw_info['home_url'] ? {"Homepage" => @raw_info['home_url']} : {})
          },
          :extra => {} # Empty for now, use this if more info is going to be added.
        }
      end

    end
  end
end
