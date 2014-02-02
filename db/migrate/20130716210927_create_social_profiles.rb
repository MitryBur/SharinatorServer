class CreateSocialProfiles < ActiveRecord::Migration
  def change
    create_table :social_profiles do |t|
      t.text :name
      t.text :surname
      t.integer :vk_id
      t.text :vk_access_token
      t.references :user
      t.timestamps
    end
  end
end
