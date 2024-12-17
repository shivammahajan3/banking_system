require_relative 'banking_system'

class Account
  include BankingSystem::Transaction
  include BankingSystem::Display

  attr_reader :account_number, :name

  @@total_accounts = 0

  def initialize(name, initial_deposit=0,aadhar)
    @name = name
    @balance = initial_deposit
    @aadhar = aadhar
    @@total_accounts += 1
    @account_number = generate_account_number
    puts "Account created successfully for #{@name} with Account Number: #{@account_number}"
  end

  private

  def generate_account_number
    "ACC#{Time.now.to_i}#{@@total_accounts}"
  end
end
