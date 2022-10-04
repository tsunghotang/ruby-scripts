require_relative 'bank_holiday'
require 'json'
require 'open-uri'
require 'date'

class BankHolidaysRepository
  attr_reader :events

  def initialize
    # call api get the objects and save them
    @events = []
    retrieve_bank_holidays_data
  end

  def next_bank_holiday
    @events.find { |event| event.date > Date.today }
  end

  def upcoming_bank_holidays
    @events.find_all { |event| event.date > Date.today }.group_by { |el| el.date.year }
  end

  def previous_bank_holidays
    @events.find_all { |event| event.date < Date.today }.group_by { |el| el.date.year }
  end

  def all
    @events.group_by { |el| el.date.year }
  end

  private

  def retrieve_bank_holidays_data
    url = 'https://www.gov.uk/bank-holidays.json'
    bank_holidays_serialized = URI.parse(url).open.read # URI.open(url).read
    bank_holidays_data = JSON.parse(bank_holidays_serialized)
    bank_holidays_list = bank_holidays_data['england-and-wales']['events']

    bank_holidays_list.each do |el|
      @events << BankHoliday.new(title: el['title'], date: Date.parse(el['date']), notes: el['notes'])
    end
  end
end
