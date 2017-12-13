trade = ['electrician', 'plumber']
day_start = Time.zone.local(2017, 12, 1, 9, 0)
today_start = Time.zone.today + 9.hours
timeslot_days = 30
timeslot_in_day = 8
#User.create!(email: 'mario@spanr.com', password: 'password', role: 2, company_id: 1, confirmed_at: Time.now.utc)

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
    company_id: rand(1..Company.all.count),
    password: 'password',
    confirmed_at: Time.now.utc
  )

  if @user.tradesman?
    timeslot_days.times do |i|
      timeslot_in_day.times do |j|
        @user.timeslots.create!(
          start_time: day_start + i.day + j.hour,
        )
      end
    end
  end
end
