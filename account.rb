class Account
  attr_reader :account_number, :name

  @@total_accounts = 0
  @@customers = {}

  def initialize(name, initial_deposit = 0, aadhar)
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
      return nil
    end
  end

  def self.get_customer_all
    return @@customers
  end

  def self.deposit(acc_num, amount)
    customer = self.get_customer(acc_num)
    if customer
      $transaction_id += 1
      if amount > 0
        customer['balance'] += amount
        puts "Deposited ₹#{amount} to account number #{acc_num}. New balance: ₹#{customer['balance']}"
        self.set_success_transaction_history(acc_num)
      else
        puts "Invalid deposit amount!"
        self.set_fail_transaction_history(acc_num)
      end
    else
      puts "Account not found!"
    end
  end

  def self.withdraw(acc_num, amount)
    customer = self.get_customer(acc_num)
    if customer
      if amount > 0 && amount <= customer['balance']
        customer['balance'] -= amount
        puts "Withdrew ₹#{amount} from account number #{acc_num}. Remaining balance: ₹#{customer['balance']}"
      else
        puts "Invalid withdrawal amount or insufficient funds!"
      end
    else
      puts "Account not found!"
    end
  end

  def self.set_success_transaction_history(sender_acc_num = "Bank",receiver_acc_num)
    $transaction_data[$transaction_id] = {
              "from_customer" => sender_acc_num,
              "to_customer" => receiver_acc_num, 
              "status" => "Success",
              "message" => "Done"
    }
  end

  def self.set_fail_transaction_history(sender_acc_num = "Bank",receiver_acc_num)
    $transaction_data[$transaction_id] = {
              "from_customer" => sender_acc_num, 
              "to_customer" => receiver_acc_num, 
              "status" => "Failure",
              "message" => "Invalid deposit amount!"
    }
  end

  private

  def generate_account_number
    "AC#{200403}#{@@total_accounts}"
  end
end
