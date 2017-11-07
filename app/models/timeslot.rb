class Timeslot < ActiveRecord::Base
  belongs_to :booking
  belongs_to :tradesman, :class_name => 'User', :foreign_key => 'tradesman_id'
end
