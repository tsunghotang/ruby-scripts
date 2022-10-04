class BankHoliday
  attr_reader :title, :date

  def initialize(attributes = {})
    @title = attributes[:title]
    @date = attributes[:date]
    @notes = attributes[:notes]
  end
end
