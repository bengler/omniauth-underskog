require 'omniauth-oauth2'
require 'multi_json'

module OmniAuth
  module Strategies
    class Underskog < OmniAuth::Strategies::OAuth2

      option :name, "underskog"

      option :client_options, {
        :site => 'https://underskog.no',
        :token_url => '/oauth/token',
        :authorize_url => '/oauth/authorize'
      }

      option :user_info_path, '/api/v1/users/current'

      uid { raw_info['uid'].to_s } # to_s to keep all values as strings

      info do
        raw_info['info']
      end

      extra do
        { 'extra' => raw_info['extra'], 'raw_info' => raw_info }
      end

      def raw_info
        url = options.client_options.site + options.user_info_path
        @raw_info ||= access_token.get(url).parsed['data']
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
            'sex' => @raw_info['sex'],
            'description' => @raw_info['description'],
            'image' => @raw_info['image_url'],
            'phone' => nil,
            'urls' => {'Underskog' => @raw_info['image_url']}.
              merge(@raw_info['home_url'] ? {"Homepage" => @raw_info['home_url']} : {})
          },
          :extra => {} # Empty for now, use this if more info is going to be added.
        }
      end

    end
  end
end
