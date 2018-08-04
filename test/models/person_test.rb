require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  test '.full_name' do
    assert_equal people(:squall_lionheart).full_name, 'Squall Lionheart'
  end
end
