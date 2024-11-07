require_relative 'stock'
require_relative 'order'
require_relative 'user'
require_relative 'portfolio'
require_relative 'order_processor'


class Exchange
    def initialize
      @users = {}
      @stocks = {}
	  @processor = OrderProcessor.new
    end

    def create_user(name, balance)
		user = User.new(name, balance)
      	@users[name] = user
		user
    end


    def add_stock(symbol, price)
      	@stocks[symbol] ||= Stock.new(symbol, price)
		@stocks[symbol]
    end

	def assign_stock_to_user(user, stock, quantity)
		user.portfolio.add_stock(stock, quantity)
	end

    def place_order(user, stock, type, price, quantity)
		if user.nil? || stock.nil?
			puts "Invalid user or stock symbol."
			return
		end

		order = Order.new(user, type, price, quantity, stock)
		@processor.add_order(order)
    end

    def display_user_holdings
		@users.each do |name, user|
			user.display_holdings
		end
    end

	def list_stocks
		puts "\nStock Listing"
		@stocks.each { |symbol, stock| puts "#{symbol} -- #{stock.price}" }
	end
end


exchange = Exchange.new
user1 = exchange.create_user("User1", 10000)
user2 = exchange.create_user("User2", 5000)
user3 = exchange.create_user("User3", 8000)


appleStock = exchange.add_stock('APL', 200)
googleStock = exchange.add_stock('GL', 300)


exchange.assign_stock_to_user(user2, appleStock, 20)
exchange.assign_stock_to_user(user3, appleStock, 30)
exchange.display_user_holdings


# Sell price less than or equal to buy price
exchange.place_order(user2, appleStock, :sell, 140, 10)
exchange.place_order(user1, appleStock, :buy, 150, 20)
exchange.display_user_holdings
exchange.list_stocks


# Sell price greater than buy price
exchange.place_order(user2, appleStock, :buy, 145, 5)
exchange.place_order(user1, appleStock, :sell, 150, 10)
exchange.display_user_holdings
exchange.list_stocks


# Sell stock to multiple users
exchange.place_order(user2, appleStock, :buy, 160, 5)
exchange.place_order(user1, appleStock, :sell, 160, 10)
exchange.place_order(user3, appleStock, :buy, 170, 5)
exchange.display_user_holdings
exchange.list_stocks
