require_relative 'employee'
require_relative 'account'

puts "-------------------------------"
puts "Welcome to the Fraud Bank (^^)"
puts "-------------------------------"

loop do
    puts "Select option in Number 1, 2 or 3"
    puts "---------------------------------"
    puts "1. Employee Registration"
    puts "2. New Account"
    puts "3. Exit"

    option = gets.to_i

    case option
    when 1
        puts "Enter Your Name"
        name = gets
        puts "Enter Your Email"
        email = gets
        puts "Enter Your Password"
        password = gets
        Employee.new(name,email,password)
    when 2
        puts "Enter Your Name"
        name = gets.chomp
        puts "Enter aadhar Number"
        aadhar = gets.to_i
        puts "Deposit Initial Fund"
        fund = gets.to_i
        account = Account.new(name,fund,aadhar)
        loop do
            puts "--------------------------------------"
            puts "Select option in Number 1, 2, 3 or 4"
            puts "--------------------------------------"
            puts "1. Deposit"
            puts "2. Withdraw"
            puts "3. Check balance"
            puts "4. Exit"
            
            account_option = gets.to_i

            case account_option
            when 1
              puts "Enter the amount to deposit:"
              amount = gets.to_f
              account.deposit(amount)
            when 2
              puts "Enter the amount to withdraw:"
              amount = gets.to_f
              account.withdraw(amount)
            when 3
              account.display_balance
            when 4
              puts "Exiting Account Menu..."
              break
            else
              puts "Invalid option. Please choose again."
            end
        end
    when 3
        puts "Thank you for visiting Fraud Bank. Goodbye!"
        break
    else
        puts "Invalid option. Please choose a valid number (1, 2 or 3)."
    end
end


