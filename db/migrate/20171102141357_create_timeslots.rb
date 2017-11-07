class CreateTimeslots < ActiveRecord::Migration
  def change
    create_table :timeslots do |t|
      t.timestamp :start_time
      t.timestamp :end_time
      t.references :booking, index: true, foreign_key: true
      t.references :tradesman, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
