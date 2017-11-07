trade = ['electrician', 'plumber']
day_start = Time.zone.local(2017, 11, 3, 9, 0)

Company.create!(
  name: "Mario the Plumber",
  address: [Faker::Address.street_address, Faker::Address.city, Faker::Address.zip_code, Faker::Address.country].join(' '),
  phone: Faker::PhoneNumber.cell_phone,
  email: Faker::Internet.email
)

Company.create!(
  name: "Sparky the Electrician",
  address: [Faker::Address.street_address, Faker::Address.city, Faker::Address.zip_code, Faker::Address.country].join(' '),
  phone: Faker::PhoneNumber.cell_phone,
  email: Faker::Internet.email
)

10.times do
  @user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    address: [Faker::Address.street_address, Faker::Address.city, Faker::Address.zip_code, Faker::Address.country].join(' '),
    mobile: Faker::PhoneNumber.cell_phone,
    email: Faker::Internet.email,
    trade: trade[rand(trade.count)],
    role: rand(1..2),
    timeslot_duration: 1.hour,
    company_id: rand(Company.all.count),
    password: 'password'
  )

  if @user.customer?
    5.times do
      @user.bookings.create!(
        notes: Faker::BackToTheFuture.quote,
      )
    end
  end

  if @user.tradesman?
    5.times do |i|
      @user.availabilities.create!(
        start_time: day_start + i.hour,
        booking_id: rand(Booking.all.count)
      )
    end
  end
end
