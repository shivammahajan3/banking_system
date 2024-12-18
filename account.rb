require_relative 'banking_system'

class Account
  include BankingSystem::Transaction
  include BankingSystem::Display

  attr_reader :account_number, :name

  @@total_accounts = 0
  @@customers = {}

  def initialize(name, initial_deposit=0,aadhar)
    @name = name
    @balance = initial_deposit
    @aadhar = aadhar
    @@total_accounts += 1
    @account_number = generate_account_number
    @@customers[@account_number] = {"name" => @name, "aadhar" => @aadhar, "balance" => @balance}
    puts "Account created successfully for #{@name} with Account Number: #{@account_number}"
  end

  def self.get_customer(acc_num)
    if @@customers.key?(acc_num)
      return @@customers[acc_num]
    else
      return false
    end
  end

  def transaction_process
    loop do
      puts "--------------------------------------"
      puts "Select option in Number 1, 2, 3 or 4"
      puts "--------------------------------------"
      puts "1. Deposit"
      puts "2. Withdraw"
      puts "3. Check balance"
      puts "4. Transfer Amount"
      puts "5. Exit"
      
      account_option = gets.to_i

      case account_option
      when 1
        puts "Enter the amount to deposit:"
        amount = gets.to_f
        self.deposit(amount)
      when 2
        puts "Enter the amount to withdraw:"
        amount = gets.to_f
        self.withdraw(amount)
      when 3
        self.display_balance
      when 4
        puts "Enter Account Number of Receiver"
        reciver_acc_num = gets.chomp
        if @@customers[reciver_acc_num]
          puts "Enter The Amount"
          amount = gets.to_i
          balance = @@customers[@account_number]['balance']
          if amount > 0 && amount <= balance
            self.account_transfer(reciver_acc_num, amount)
          else
            puts "Please Enter a Valid amount"
          end
        else
          puts "Customer Not found! Please enter a valid Account Number!"
        end      
      when 5
        puts "Exiting Account Menu..."
        break
      else
        puts "Invalid option. Please choose again."
      end
    end
  end


  def account_transfer(account_num, amount)
    if @@customers[account_num]
      @@customers[@account_number]['balance'] -= amount
      @@customers[account_num]['balance'] += amount
      puts "Transferred ₹#{amount} to Account Number: #{account_num}. New balance: ₹#{@@customers[@account_number]['balance']}"
    else
      puts "Invalid receiver account number!"
    end
  end

  private

  def generate_account_number
    "AC#{200456}#{@@total_accounts}"
  end
end
