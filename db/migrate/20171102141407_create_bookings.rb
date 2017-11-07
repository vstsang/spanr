class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.text :notes
      t.references :customer, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
