# Write a game where the player has to guess a random number between 1 and 100 chosen by the program.
# The program should keep asking until the player guesses the right price.
# When the guess is right, the program displays how many guesses it took the player to win.


require_relative 'number-guesser'

MIN = 1
MAX = 100

puts "-----------------------------------------------------"
puts "-----I'm thinking of a number between 1 and 100.-----"
puts "--------Try to guess it in the fewest turns.---------"
puts "-----------------------------------------------------"
puts ''

guess = nil
guesses = 0
target_number = rand(MIN..MAX)

puts "What is your guess?"

until guess == target_number
  guess = gets.chomp.to_i
  guesses += 1
  higher_or_lower(target_number, guess)
end

puts '******************************'
puts '-------Congratulations!-------'
puts '******************************'
puts ''

puts "The number is #{target_number}"
format_gusses(guesses)
