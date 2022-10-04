require_relative 'bank_holidays_view'
require_relative 'bank_holidays_repository'

class BankHolidaysController
  def initialize(bank_holidays_repostiory)
    @repository = bank_holidays_repostiory
    @view = BankHolidaysView.new
  end

  def next_bank_holiday
    @view.print_next_bank_holiday(@repository.next_bank_holiday)
  end

  def upcoming_bank_holidays
    @view.print_bank_holidays((@repository.upcoming_bank_holidays))
  end

  def previous_bank_holidays
    @view.print_bank_holidays(@repository.previous_bank_holidays)
  end

  def all_bank_holidays
    @view.print_bank_holidays(@repository.all)
  end
end
