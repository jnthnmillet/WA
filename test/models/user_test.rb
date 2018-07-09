require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test ".person.name" do
    assert_equal users(:user_squall).person.name, "Squall Lionheart"
  end
end
