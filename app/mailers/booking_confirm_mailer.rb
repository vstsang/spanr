class BookingConfirmMailer < ApplicationMailer
  default from: ENV['BOOKING_FROM_EMAIL']

  def email_confirmation(booking)
    @booking = booking
    @company = @booking.timeslot.tradesman.company

    @date = @booking.timeslot.start_time.strftime('%A, %v')
    @time = @booking.timeslot.start_time.strftime('%I:%M %p')

    @customer_first_name = @booking.first_name
    @customer_full_name = [@booking.first_name, @booking.last_name].reject(&:empty?).join(' ')
    @customer_address = @booking.address
    @customer_email = @booking.email
    @customer_mobile = @booking.mobile
    @notes = @booking.notes

    @company_name = @booking.timeslot.tradesman.company.name
    @company_address = @booking.timeslot.tradesman.company.address
    @company_email = @booking.timeslot.tradesman.company.email
    @company_phone = @booking.timeslot.tradesman.company.phone

    mail(to: @customer_email, cc: ENV['BOOKING_FROM_EMAIL'], subject: "Booking confimred - #{@company_name}")
  end
end
