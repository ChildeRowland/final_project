class CreateProfilesTable < ActiveRecord::Migration
  def change
  	create_table :profiles do |t|
      t.integer :user_id
  		t.text :bio
  		t.integer :age
  		t.string :species
  		t.string :city
  		t.string :state
      t.string :picture
  		t.binary :pic
  	end
  end
end
