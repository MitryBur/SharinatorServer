require 'test_helper'

class SocialProfileTest < ActiveSupport::TestCase
  fixtures :social_profiles
  test 'should have name' do
    social = SocialProfile.new(surname:'Powers', vk_id:1000)
    assert social.invalid?
    assert_equal [I18n.translate('errors.messages.blank')], social.errors[:name]
  end
  test 'should have surname' do
    social = SocialProfile.new(name:'John', vk_id:1000)
    assert social.invalid?
    assert_equal [I18n.translate('errors.messages.blank')], social.errors[:surname]
  end
  test 'should have vk_id' do
    social = SocialProfile.new(name: 'John', surname:'Powers')
    assert social.invalid?
    assert_equal [I18n.translate('errors.messages.blank')], social.errors[:vk_id]
  end
  test 'should have unique vk_id' do
    social = SocialProfile.new(name: 'Max', surname: 'Powers', vk_id: social_profiles(:mitry_profile).vk_id)
    assert social.invalid?
    assert_equal [I18n.translate('errors.messages.taken')], social.errors[:vk_id]
  end
  test 'should have unique vk_access_token if not blank' do
    social = SocialProfile.new(name: 'Max', surname: 'Powers', vk_id: 1000)
    assert social.valid?
    social.vk_access_token = social_profiles(:misha_profile).vk_access_token
    assert social.invalid?
    assert_equal [I18n.translate('errors.messages.taken')], social.errors[:vk_access_token]
  end
end