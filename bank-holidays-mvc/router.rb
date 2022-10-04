class Router
  def initialize(controller, args)
    @controller = controller

    if args[0] == '--options' || args[0] == '-o'
      args.clear
      run
    else
      action(1)
    end
  end

  def run
    loop do
      puts ""
      puts "What would you like to do?"
      display_options
      print "> "
      user_choice = gets.chomp.to_i
      system('clear')
      action(user_choice)
    end
  end

  private

  def display_options
    puts "1 - List next bank holiday"
    puts "2 - List upcoming bank holidays for current year"
    puts "3 - List previous bank holidays"
    puts "4 - List all bank holidays"
    puts "0 - Quit"
  end

  def action(choice)
    case choice
    when 1 then @controller.next_bank_holiday
    when 2 then @controller.upcoming_bank_holidays
    when 3 then @controller.previous_bank_holidays
    when 4 then @controller.all_bank_holidays
    when 0 then exit
    end
  end
end
