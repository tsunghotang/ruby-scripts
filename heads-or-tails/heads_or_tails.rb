run = true
round = 0
win_count = 0
consecutive_wins = 0

COIN = [['Heads', 'heads', 'h', 'H'], ['Tails', 'tails', 't', 'T']]
DECISION = [['y', 'Y', 'yes', 'Yes'], ['n', 'N', 'no', 'No']]

def calc_winrate(win_count, round)
  (win_count / round.to_f * 100).round
end

def output_result(round, flipped_coin, result, win_count, consecutive_wins)
  puts ''
  puts "-------------------------Round #{round}-------------------------"
  puts "------------You #{result}!, the coin landed on #{flipped_coin[0]}------------"
  puts "--------You've won #{win_count} out of #{round} rounds (#{calc_winrate(win_count, round)}% win rate)--------"
  puts "---------------------Current Streak #{consecutive_wins}---------------------"
  puts '----------------------------------------------------------'
  puts ''
end

def valid_input?(reference, input)
  reference.flatten.include?(input)
end

def play_again?(run)
  DECISION[0].include?(run)
end

until run == false
  round += 1
  choice = nil
  puts "Heads? or Tails?"
  until valid_input?(COIN, choice)
    print '=> '
    choice = gets.chomp.downcase
    puts "Invalid input. Try again (Heads? or Tails?)" unless valid_input?(COIN, choice)
  end

  flipped_coin = COIN.sample
  result = flipped_coin.include?(choice) ? 'win' : 'lose'
  result == 'win' ? consecutive_wins += 1 : consecutive_wins = 0
  win_count += 1 if result == 'win'
  puts ""
  puts "Flipping coin.."
  sleep 1
  output_result(round, flipped_coin, result, win_count, consecutive_wins)

  loop do
    puts "Would you like to play again? (y or n)"
    user_input = gets.chomp
    if valid_input?(DECISION, user_input)
      run = play_again?(user_input)
      break
    end
  end
end
