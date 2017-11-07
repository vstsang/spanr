class Booking < ActiveRecord::Base
  belongs_to :customer, :class_name => 'User', :foreign_key => 'customer_id'
  has_one :timeslot
end
