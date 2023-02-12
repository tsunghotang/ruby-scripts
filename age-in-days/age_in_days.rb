# Get user BD
def ask_for(param, days_in_month = 0)
  ask_for = "Please enter your #{param} of birth?"
  ask_for << " (1-#{days_in_month})" if param == 'day'

  puts ask_for

  retrieve_user_input(param, days_in_month)
end

def retrieve_user_input(param, days_in_month)
  input = ''
  loop do
    print '=> '
    input = gets.chomp.to_i
    valid_input?(input, param, days_in_month) ? break : invalid_input(param, days_in_month)
  end
  input
end

def user_dob
  birth_year, birth_month, birth_day = nil
  loop do
    birth_year = ask_for('year')
    birth_month = ask_for('month')

    no_of_days_in_month = days_in_months(birth_year)[birth_month]
    birth_day = ask_for('day', no_of_days_in_month)

    valid_date?(birth_year, birth_month, birth_day) ? break : invalid_input('date')
  end
  Date.new(birth_year, birth_month, birth_day)
end

def build_days_regex(days_in_month)
  if days_in_month >= 30
    Regexp.new("^([1-9]|1[019]|2[029]|3[0#{days_in_month}])$")
  elsif days_in_month < 30
    Regexp.new("^([1-9]|1[019]|2[0#{days_in_month}])$")
  end
end

def valid_input?(input, type, days_in_month)
  case type
  when 'year' then (input.to_i >= 1800 && input <= Date.today.year)
  when 'month' then !/^(0?[1-9]|1[012])$/.match(input.to_s).nil?
  when 'day' then !build_days_regex(days_in_month).match(input.to_s).nil?
  end
end

def invalid_input(param, days_in_month = 0)
  case param
  when 'year'
    puts "Invalid year. Please enter a year between 1800 and #{Date.today.year}"
  when 'month'
    puts "Invalid month. Please enter a valid month (1 - 12)"
  when 'day'
    puts "Invalid day. There are only #{days_in_month} in the month and year specified"
  when 'date'
    puts "Invalid date given. Date must be in the past"
  end
end

def valid_date?(year, month, day)
  Date.valid_date?(year, month, day) && Date.new(year, month, day) <= Date.today
end

########################################

def format_str(data, text)
  data == 1 ? "#{data} #{text}" : "#{data} #{text}s"
end

# Calc info
###########################################

def calc_age_in_months(current_date, birthday)
  diff_year = calc_diff(current_date.year, birthday.year)
  diff_month = calc_diff(current_date.month, birthday.month)

  (diff_year * 12) + diff_month - (current_date.day >= birthday.day ? 0 : 1)
end

def calc_age_in_weeks(current_date, birthday)
  { weeks: calc_diff(current_date, birthday).to_i / 7, days: calc_diff(current_date, birthday).to_i % 7 }
end

def calc_days_until_birthday(current_date, dob)
  upcoming_birthday = Date.new(current_date.year, dob.month, dob.day)
  upcoming_birthday = upcoming_birthday.next_year if upcoming_birthday < current_date
  (upcoming_birthday - current_date).to_i
end

def calc_day_of_week_bd(current_date, dob)
  upcoming_birthday = Date.new(current_date.year, dob.month, dob.day)
  days_until_bd = (upcoming_birthday - current_date).to_i
  return [upcoming_birthday.next_year, upcoming_birthday] if days_until_bd.zero? || days_until_bd.negative?

  [upcoming_birthday, upcoming_birthday.prev_year]
end

def generate_data(current_date, birthday)
  { current_date: current_date,
    birthday: birthday,
    age: calc_age(current_date, birthday),
    age_in_days: calc_diff(current_date, birthday).to_i,
    age_in_months: calc_age_in_months(current_date, birthday),
    age_in_weeks: calc_age_in_weeks(current_date, birthday),
    days_untill_bd: calc_days_until_birthday(current_date, birthday),
    day_of_wk_birth: birthday.strftime('%A'),
    day_of_wk_prev_bd: calc_day_of_week_bd(current_date, birthday)[1].strftime("%A"),
    day_of_wk_next_bd: calc_day_of_week_bd(current_date, birthday)[0].strftime("%A") }
end

# Logic for calc Age

def leap?(year)
  Date.new(year).leap?
end

def days_in_months(year)
  days_in_months = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  leap?(year) ? days_in_months[2] = 29 : days_in_months
  days_in_months
end

def calc_diff(current_date, birthday)
  current_date - birthday
end

def calc_age(current_date, birthday)
  diff_year = calc_diff(current_date.year, birthday.year)
  diff_month = calc_diff(current_date.month, birthday.month)
  diff_day = calc_diff(current_date.day, birthday.day)

  diff_day, diff_month = days_in_months(current_date.year)[current_date.month - 1] + diff_day, diff_month -= 1 if diff_day.negative?
  diff_year = diff_year -= 1 if diff_month.negative?
  diff_month += 12 if diff_month.negative?

  { year: diff_year, month: diff_month, day: diff_day }
end

# unused method
# def print_details(data)
#   system('clear')
#   puts "---------------------------------------------"
#   puts "Birthdate 🎂: #{data[:birthday]} (#{data[:birthday].strftime('%b %e')})"
#   puts "Today's date 🗓️: #{data[:current_date]} (#{data[:current_date].strftime('%b %e')})"
#   puts "---------------------------------------------"
#   puts ""
#   puts "You are #{data[:age_in_days]} days old." # emoji function
#   puts "Which is #{format_text(data[:age_in_weeks][:weeks], 'week')} and #{format_text(data[:age_in_weeks][:days], 'day')}."
#   puts "That's #{format_text(data[:age][:year], 'year')} #{format_text(data[:age][:month], 'month')} and #{format_text(data[:age][:day], 'day')}."
#   puts "In other words, That's #{format_text(data[:age_in_months], 'month')}."
#   puts "Therefore, you are #{data[:age][:year]} years old."
#   puts ""
#   puts "You were born on a #{data[:day_of_week_birth]}."
#   puts "Your last birthday was a #{data[:day_of_week_prev_bd]} and your next one will be on a #{data[:day_of_week_upcoming_bd]}."
#   puts ""

#   puts "There are #{format_text(data[:days_untill_bd], 'day')} till your birthday"
#   puts "Happy Birthday 🥳" if data[:days_untill_bd].zero?
# end
