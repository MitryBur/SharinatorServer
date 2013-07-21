class AddTokenSocial < ActiveRecord::Migration
  def change
			add_column :socials, :vk_token, :string
  end
end
