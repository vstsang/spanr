class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  belongs_to :company
  has_many :timeslots, :class_name => 'Timeslot', :foreign_key => 'tradesman_id'
  has_many :bookings, :class_name => 'Booking', :foreign_key => 'customer_id'

  enum role: [:admin, :customer, :tradesman]

  # defaults user to customer unless specified
  def init
    self.role ||= :customer
  end
end
