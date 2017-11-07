class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :mobile
      t.string :email
      t.integer :role
      t.integer :trade
      t.integer :timeslot_duration
      t.references :company, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
