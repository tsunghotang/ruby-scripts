require_relative 'age_in_days'
require 'date'

current_date = Date.today
birthday = user_dob # returns Date object
data = generate_data(current_date, birthday) # generate all the data needed to print the details
system('clear')
puts "---------------------------------------------"
puts "Birthdate 🎂: #{data[:birthday]} (#{data[:birthday].strftime('%b %e')})"
puts "Today's date 🗓️: #{data[:current_date]} (#{data[:current_date].strftime('%b %e')})"
puts "---------------------------------------------"
puts ""
puts "You are #{data[:age_in_days]} days old." # emoji function
puts "Which is #{format_str(data[:age_in_weeks][:weeks], 'week')} and #{format_str(data[:age_in_weeks][:days], 'day')}."
puts "That's #{format_str(data[:age][:year], 'year')} #{format_str(data[:age][:month], 'month')} and #{format_str(data[:age][:day], 'day')}."
puts "In other words, That's #{format_str(data[:age_in_months], 'month')}."
puts "Therefore, you are #{data[:age][:year]} years old."
puts ""
puts "You were born on a #{data[:day_of_wk_birth]}."
puts "Your last birthday was a #{data[:day_of_wk_prev_bd]} and your next one will be on a #{data[:day_of_wk_next_bd]}."
puts ""

puts "There are #{format_str(data[:days_untill_bd], 'day')} till your birthday"
puts "Happy Birthday 🥳" if data[:days_untill_bd].zero?
