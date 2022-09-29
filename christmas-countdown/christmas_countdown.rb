# Psudo Code
#   Require date module
#   Find today's date
#   Find date of next christmas
#   Find difference between days - christmas - today
#   Convert to integer dates to intergers
#   Return method

require 'date'

def days_until_christmas(date = Date.today)
  days_until_xmas = calc_days_until_christmas(date)
  display_message(days_until_xmas)
end

private

def calc_days_until_christmas(date)
  christmas = Date.new(date.year, 12, 25)
  christmas = christmas.next_year if christmas < date
  (christmas - date).to_i
end

def display_message(days)
  return "#{days} day till Christmas" if days == 1
  return 'Ho Ho Ho Merry Christmas 🎅🏻🎁' if days.zero?

  "#{days} days till Christmas"
end

puts days_until_christmas
