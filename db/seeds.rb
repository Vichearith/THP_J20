Faker::Config.locale = :fr

City.destroy_all
User.destroy_all
Reservation.destroy_all
Listing.destroy_all
City.reset_pk_sequence
User.reset_pk_sequence
Reservation.reset_pk_sequence
Listing.reset_pk_sequence

10.times do
  city = City.create!(
    zip_code:  Faker::Address.postcode, 
    name:  Faker::Address.city)
end

20.times do
  user = User.create!(
    first_name: Faker::Name.first_name, 
    last_name: Faker::Name.last_name, 
    description: Faker::Lorem.paragraphs, 
    email: Faker::Internet.email, 
    phone_number: Faker::PhoneNumber.phone_number)
end

50.times do
  listing = Listing.create!(
    available_beds: Faker::Number.between(from: 1, to: 12), 
    price: Faker::Number.between(from: 50, to: 300), 
    description: Faker::Lorem.paragraphs, 
    has_wifi: Faker::Boolean.boolean, 
    welcome_message: Faker::Lorem.paragraphs,
    admin: User.all.sample,
    city: City.all.sample)
end

Listing.all.each do |listing|
  5.times do
    start_date = Faker::Date.between_except(from: Date.today, to: 1.year.from_now, excepted: Date.today)
    end_date = start_date + rand(1..10)
    reservation = Reservation.create!(
      start_date: start_date, 
      end_date: end_date,
      listing: listing,
      guest: User.all.sample)
  end

  5.times do
    start_date = Faker::Date.between_except(from: 1.year.ago, to: Date.today, excepted: Date.today)
    end_date = start_date + rand(1..10)
    reservation = Reservation.create!(
      start_date: start_date,
      end_date: end_date, 
      listing: listing,
      guest: User.all.sample)
  end

end