class Transaction
    $transaction_id = 0
    $transaction_data = {}

    def self.transaction_process
      loop do
        puts "--------------------------------------"
        puts "Select transaction option:"
        puts "1. Deposit"
        puts "2. Withdraw"
        puts "3. Check balance"
        puts "4. Transfer Amount"
        puts "5. Transaction History"
        puts "6. Exit"
        
        option = gets.to_i
  
        case option
        when 1
          puts "Enter Account Number:"
          acc_num = gets.chomp
          puts "Enter the amount to deposit:"
          amount = gets.to_f
          Account.deposit(acc_num, amount)
        when 2
          puts "Enter Account Number:"
          acc_num = gets.chomp
          puts "Enter the amount to withdraw:"
          amount = gets.to_f
          Account.withdraw(acc_num, amount)
        when 3
          puts "Enter Account Number:"
          acc_num = gets.chomp
          display_balance(acc_num)
        when 4
          puts "Enter Account Number of Receiver"
          receiver_acc_num = gets.chomp
          puts "Enter Account Number of Sender"
          sender_acc_num = gets.chomp
          if Account.get_customer(receiver_acc_num)
            puts "Enter The Amount"
            amount = gets.to_f
            transfer_amount(sender_acc_num, receiver_acc_num, amount)
          else
            puts "Customer Not found! Please enter a valid Account Number!"
          end
        when 5
          puts "Enter Account Number for Transaction History"
          acc_num = gets.chomp
          Transaction.get_transaction_history(acc_num)
        when 6
          puts "Exiting Transaction Menu..."
          break
        else
          puts "Invalid option. Please choose again."
        end
      end
    end
  
    def self.display_balance(acc_num)
      customer = Account.get_customer(acc_num)
      if customer
        puts "Account holder: #{customer['name']}"
        puts "Account number: #{acc_num}"
        puts "Current balance: ₹#{customer['balance']}"
      else
        puts "Account not found!"
      end
    end
  
    def self.transfer_amount(sender_acc_num, receiver_acc_num, amount)
      sender = Account.get_customer(sender_acc_num)
      receiver = Account.get_customer(receiver_acc_num)

      if sender && receiver
        $transaction_id += 1
        if amount > 0 && amount <= sender['balance']
          sender['balance'] -= amount
          receiver['balance'] += amount
          puts "Transferred ₹#{amount} from account number #{sender_acc_num} to account number #{receiver_acc_num}"
          
          $transaction_data[$transaction_id] = {
            "from_customer" => sender_acc_num, 
            "to_customer" => receiver_acc_num, 
            "status" => "Success",
            "message" => "Done"
          }
        else
          puts "Invalid transfer amount or insufficient funds!"
          
          $transaction_data[$transaction_id] = {
            "from_customer" => sender_acc_num,
            "to_customer" => receiver_acc_num,
            "status" => "Failure",
            "message" => "Insufficient funds"
          }
        end
      else
        puts "Invalid sender or receiver account number!"
      end
    end

    def self.get_transaction_history(acc_num)
        selected_history = $transaction_data.values.select do |transaction|
            transaction["from_customer"] == acc_num || transaction["to_customer"] == acc_num    
        end

        if selected_history.empty?
            puts "No transaction history found for account number #{acc_num}"
        else
            selected_history.each do |history|
                from_customer = Account.get_customer(history["from_customer"])
                to_customer = Account.get_customer(history["to_customer"])

                if from_customer
                    puts "From Customer: #{from_customer['name']} (#{history['from_customer']})"
                else
                    puts "From : Bank"
                end

                if to_customer
                    puts "To Customer: #{to_customer['name']} (#{history['to_customer']})"
                else
                    puts "To : Bank"
                end
                puts "Status: #{history['status']}"
                puts "Message: #{history['message']}"
                puts "-" * 35
            end
        end
    end
end
