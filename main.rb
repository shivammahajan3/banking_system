require_relative 'account'
require_relative 'transaction'

puts "-------------------------------"
puts "Welcome to the Bank (^^)"

account = nil 

loop do
    puts "-------------------------------------"
    puts "Select option in Number 1, 2, 3 or 4"
    puts "-------------------------------------"
    puts "1. Create New Account"
    puts "2. Search Customers"
    puts "3. Transaction"
    puts "4. All Customer Details"
    puts "5. Exit"

    option = gets.to_i

    case option
    when 1
        puts "Enter Your Name"
        name = gets.chomp
        puts "Enter aadhar Number"
        aadhar = gets.to_i
        puts "Deposit Initial Fund"
        fund = gets.to_f
        account = Account.new(name, fund, aadhar)
    when 2
        puts "Enter Account Number"
        account_number = gets.chomp
        customer = Account.get_customer(account_number)
        if customer
            puts "Customer Info:"
            puts "Name: #{customer['name']}"
            puts "Aadhar: #{customer['aadhar']}"
            puts "Balance: #{customer['balance']}"
        else
            puts "Customer Not found! Please enter valid account number"
        end
    when 3
        if account.nil?
            puts "You need to create an account first!"
        else
            Transaction.transaction_process
        end
    when 4
        customers = Account.get_customer_all
        customers.each do |acc_num, value|
            puts "-" * 35
            puts "Customer Info:"
            puts "Name: #{value['name']}"
            puts "Aadhar: #{value['aadhar']}"
            puts "Balance: #{value['balance']}"
        end
    when 5
        puts "Thank you for visiting Bank. Goodbye!"
        break
    else
        puts "Invalid option. Please choose a valid number (1, 2 or 3)."
    end
end
