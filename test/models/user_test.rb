require 'test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users
  test 'user has name from profile' do
    assert_not_equal users(:mitry).social_profile.name, 'Lox'
    assert_equal users(:mitry).social_profile.name, 'Mitry'
  end
  test 'social profile deletes after user deletion' do
    user = User.create
    social = SocialProfile.create(vk_id: 1, vk_access_token: 'afgfgsdgf', name: 'John', surname: 'Great')
    user.social_profile = social
    user.destroy
    assert user.destroyed?, message: 'Should be destroyed'
    assert !SocialProfile.exists?(social), message: 'Social profile should be destroyed as well'
  end
end
