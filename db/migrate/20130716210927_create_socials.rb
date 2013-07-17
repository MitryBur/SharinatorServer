class CreateSocials < ActiveRecord::Migration
  def change
    create_table :socials do |t|
	  t.belongs_to :user
      t.text :name
      t.text :surname
      t.string :social_id
      t.timestamps
    end
  end
end
