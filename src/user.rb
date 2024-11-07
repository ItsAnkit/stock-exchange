class User
    attr_accessor :name, :portfolio, :balance
  
    def initialize(name, balance)
      @name = name
      @portfolio = Portfolio.new
      @balance = balance
    end
  
    def place_order(type, stock, quantity)
      Order.new(type, stock, quantity, self)
    end

    def deposit(amount)
        @balance += amount
    end

    def withdraw(amount)
        if @balance >= amount
            @balance -= amount
            true
        else
            puts "Not enough balance to withdraw amount #{amount}"
            false
        end
    end

    def display_holdings
		puts "\nHoldings for User: #{@name}"
        puts "Balance: #{@balance}"
		@portfolio.display_holdings
    end
end
