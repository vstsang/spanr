class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :email
      t.string :mobile
      t.text :notes
      t.references :customer, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
