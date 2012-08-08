require 'spec_helper'

describe OmniAuth::Strategies::Underskog do
  subject do
    OmniAuth::Strategies::Underskog.new(nil, @options || {})
  end

  it_should_behave_like 'an oauth2 strategy'

  describe '#client' do
    it 'has correct site URL' do
      subject.client.site.should == 'https://underskog.no'
    end

    it 'has correct authorize URL' do
      subject.client.authorize_url.should == 'https://underskog.no/oauth/authorize'
    end

    it 'has correct token URL' do
      subject.client.token_url.should == 'https://underskog.no/oauth/token'
    end

    it 'has correct userinfo path' do
      subject.options.user_info_path.should == '/api/v1/users/current'
    end

  end

  describe '#callback_path' do
    it "has the correct callback path" do
      subject.callback_path.should eq('/auth/underskog/callback')
    end
  end

end
