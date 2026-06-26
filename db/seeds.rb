puts "Clearing old data..."
Flight.destroy_all
Airport.destroy_all

puts "Creating airports..."
sfo = Airport.create!(code: 'SFO')
nyc = Airport.create!(code: 'NYC')
lax = Airport.create!(code: 'LAX')
ord = Airport.create!(code: 'ORD')
mia = Airport.create!(code: 'MIA')

puts "Creating flights..."

flight_data = [
  { departure: sfo, arrival: nyc, start: 1.day.from_now.change(hour: 8), duration: 330 },
  { departure: sfo, arrival: lax, start: 1.day.from_now.change(hour: 14), duration: 90 },
  { departure: lax, arrival: ord, start: 2.days.from_now.change(hour: 10), duration: 240 },
  { departure: ord, arrival: mia, start: 2.days.from_now.change(hour: 16), duration: 180 },
  { departure: mia, arrival: nyc, start: 3.days.from_now.change(hour: 7), duration: 150 },
  { departure: nyc, arrival: sfo, start: 3.days.from_now.change(hour: 18), duration: 360 },
  { departure: lax, arrival: sfo, start: 4.days.from_now.change(hour: 9), duration: 95 },
  { departure: mia, arrival: sfo, start: 4.days.from_now.change(hour: 12), duration: 340 }
]

flight_data.each do |data|
  Flight.create!(
    departure_airport: data[:departure],
    arrival_airport: data[:arrival],
    start_datetime: data[:start],
    duration: data[:duration]
  )
end

puts "Successfully created #{Airport.count} airports!"
