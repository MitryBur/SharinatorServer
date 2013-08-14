class SocialidToInteger < ActiveRecord::Migration

  #def up
   # change_column :socials, :social_id, :integer
begin
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
