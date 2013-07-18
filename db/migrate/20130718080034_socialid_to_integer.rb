class SocialidToInteger < ActiveRecord::Migration
		def up
				connection.execute(%q{
            alter table socials
            alter column social_id
            type integer using cast(number as integer)
        })
		end
		def change
		  change_column :socials, :social_id, :integer
		  change_column :users, :social_id, :integer
  end
end
