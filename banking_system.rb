# BankingSystem Module
module BankingSystem
  module Transaction
    def deposit(amount)
      if amount > 0
        @balance += amount
        puts "Deposited ₹#{amount}. New balance: ₹#{@balance}"
      else
        puts "Invalid deposit amount!"
      end
    end

    def withdraw(amount)
      if amount > 0 && amount <= @balance
        @balance -= amount
        puts "Withdrew ₹#{amount}. Remaining balance: ₹#{@balance}"
      else
        puts "Invalid withdrawal amount or insufficient funds!"
      end
    end
  end

  module Display
    def display_balance
      puts "Account holder: #{@name}"
      puts "Aadhar number: #{@aadhar}"
      puts "Current balance: ₹#{@balance}"
    end
  end
end