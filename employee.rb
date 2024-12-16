class Employee
    @@employee_count = 0
    @@employee_data = {}
  
    def initialize(name, email, password)
      @@employee_count += 1
      @name = name
      @email = email
      @password = password
      @@employee_data[@@employee_count] = { "name" => @name, "email" => @email, "password" => @password }
    end
  
    def valid_employee?(id)
        puts "Enter Your Email:"
        email = gets.chomp
        if @@employee_data[id] && @@employee_data[id]["email"] == email
            puts "Enter Your Password:"
            password = gets.chomp
    
            if @@employee_data[id]["password"] == password
                puts "Welcome, #{@@employee_data[id]['name']}!"
                return true
            else
                puts "Your password is incorrect."
            end
        else
            puts "Your email is not valid."
        end
        return false
    end
end

shiv = Employee.new("Shivam", "shivam@gmail.com", "shivam123")
puts shiv.inspect
shiv.valid_employee?(1)
