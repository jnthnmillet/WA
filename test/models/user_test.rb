require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test '.person.full_name' do
    assert_equal users(:user_squall).person.full_name, 'Squall Lionheart'
  end

  test 'Mock Login for Google Auth' do
    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
      provider: 'google_provider',
      uid: '1111111111',
      info: {
        name: 'Google User',
        email: 'cloud@example.com'
      }
    )
  end
end
