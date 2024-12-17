require_relative 'account'
require_relative 'employee'
include BankingSystem

puts "-------------------------------"
puts "Welcome to the Fraud Bank (^^)"
puts "-------------------------------"

puts "Select option in Number 1 or 2"
puts "-------------------------------"
puts "1. Employee Registration"
puts "2. New Account"

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
    name = gets
    puts "Enter aadhar Number"
    aadhar = gets.to_i
    puts "Enter Contact Number"
    contact = gets.to_i
    puts "Deposit Initial Fund"
    fund = gets.to_i
    Account.new(name,fund,contact,aadhar)
else
    puts "Invalid option. Please choose a valid number (1 or 2)."
end
