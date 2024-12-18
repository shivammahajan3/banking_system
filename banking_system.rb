# BankingSystem Module
module BankingSystem
  module Transaction
    def deposit(acc_num,amount)
      customer = Account.get_customer(acc_num)
      if customer
        if amount > 0
          @balance += amount
          puts "Account holder: #{customer['name']}"
          puts "Account Number: #{acc_num}"
          puts "Deposited ₹#{amount}. New balance: ₹#{@balance}"
        else
          puts "Invalid deposit amount!"
        end
      else
        puts "Something went Wrong!"
      end      
    end

    def withdraw(acc_num,amount)
      customer = Account.get_customer(acc_num)
      if customer
        if amount > 0 && amount <= @balance
          @balance -= amount
          puts "Account holder: #{customer['name']}"
          puts "Account Number: #{acc_num}"
          puts "Withdrew ₹#{amount}. Remaining balance: ₹#{@balance}"
        else
          puts "Invalid withdrawal amount or insufficient funds!"
        end
      else
        puts "Something went Wrong!"
      end
    end
  end

  module Display
    def display_balance(acc_num)
      customer = Account.get_customer(acc_num)
      if customer
        puts "Account holder: #{customer['name']}"
        puts "Account number: #{acc_num}"
        puts "Current balance: ₹#{customer['balance']}"
      else
        puts "Something went Wrong!"
      end
    end
  end
end