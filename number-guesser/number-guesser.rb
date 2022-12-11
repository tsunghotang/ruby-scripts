def higher?(target, number)
  number > target
end

def higher_or_lower(target, number)
  if higher?(target, number)
    puts "Too High!! Take another guess!"
  else
    puts "Too low!! Take another guess!"
  end
end

def format_gusses(guesses)
  if guesses == 1
    puts "It took you #{guesses} guess"
  else
    puts "It took you #{guesses} guesses"
  end
end
