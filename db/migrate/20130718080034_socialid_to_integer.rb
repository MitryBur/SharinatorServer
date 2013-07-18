class SocialidToInteger < ActiveRecord::Migration
		def up
				connection.execute(%q{
            alter table socials
            alter column social_id
            type integer using cast(social_id as integer)
        })
				connection.execute(%q{
            alter table users
            alter column social_id
            type integer using cast(social_id as integer)
        })
		end
end
