require 'omniauth-oauth2'
require 'multi_json'

module OmniAuth
  module Strategies
    class Underskog < OmniAuth::Strategies::OAuth2

      USERINFO_ENDPOINT = 'https://origo.no/-/api/v2/user/omniauth_hash'

      option :name, "origo"

      # TODO: make this support HTTPS when bug in Origo /-/site/check_mastersession
      # is resolved. See README.md
      option :client_options, {
        :site => 'https://secure.origo.no',
        :token_url => '/-/oauth/token',
        :authorize_url => '/-/oauth/authorize'
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
      end

    end
  end
end
