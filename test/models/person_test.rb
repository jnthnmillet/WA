require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  test '.name' do
    assert_equal people(:squall_lionheart).name, 'Squall Lionheart'
  end
end
