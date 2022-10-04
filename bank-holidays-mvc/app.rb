require_relative 'router'
require_relative 'bank_holidays_controller'
require_relative 'bank_holidays_repository'

repository = BankHolidaysRepository.new
controller = BankHolidaysController.new(repository)

Router.new(controller, ARGV)
