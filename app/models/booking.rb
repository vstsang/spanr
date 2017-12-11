class Booking < ActiveRecord::Base
  belongs_to :customer, :class_name => 'User', :foreign_key => 'customer_id'
  has_one :timeslot, dependent: :nullify

  validates_presence_of :first_name, :last_name, :address, :email, :mobile

  after_create :send_confirm_emails

  private

  def send_confirm_emails
    BookingConfirmMailer.email_confirmation(self).deliver_now
  end

end
