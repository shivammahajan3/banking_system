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
        record_transaction("Bank", acc_num, "Success", "Deposit successful")
      else
        puts "Invalid deposit amount!"
        record_transaction("Bank", acc_num, "Failure", "Invalid deposit amount")
      end
    else
      puts "Account not found!"
    end
  end

  def self.withdraw(acc_num, amount)
    customer = self.get_customer(acc_num)
    if customer
      $transaction_id += 1
      if amount > 0 && amount <= customer['balance']
        customer['balance'] -= amount
        puts "Withdrew ₹#{amount} from account number #{acc_num}. Remaining balance: ₹#{customer['balance']}"
        record_transaction(acc_num, "Bank", "Success", "Withdrawal successful")
      else
        puts "Invalid withdrawal amount or insufficient funds!"
        record_transaction(acc_num, "Bank", "Failure", "Insufficient funds or invalid amount")
      end
    else
      puts "Account not found!"
    end
  end

  def self.record_transaction(from_customer, to_customer, status, message)
    $transaction_data[$transaction_id] = {
      "from_customer" => from_customer,
      "to_customer" => to_customer,
      "status" => status,
      "message" => message
    }
  end

  private

  def generate_account_number
    "AC#{200403}#{@@total_accounts}"
  end
end
