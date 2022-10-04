require 'terminal-table'

class BankHolidaysView
  def print_next_bank_holiday(data)
    puts "The next bank holiday in England and Wales is: #{data.title} - #{data.date.strftime('%d %B %Y')}"
  end

  def print_bank_holidays(data)
    data.each do |year, array|
      rows = []
      array.each { |event| rows << ["#{event.title}",  "#{event.date.strftime("%d %B %Y")}"] }
      table = Terminal::Table.new :title => "#{year}", :rows => rows
      puts ''
      puts table
    end
  end
end
