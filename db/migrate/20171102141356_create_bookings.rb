class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :email
      t.string :mobile
      t.text :notes
      t.references :customer, index: true

      t.timestamps null: false
    end
    add_foreign_key :bookings, :users, column: :customer_id
  end
end
