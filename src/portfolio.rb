class Portfolio
    attr_accessor :holdings
  
    def initialize
      	@holdings = Hash.new(0) 
    end
  
    def add_stock(stock, quantity)
      	@holdings[stock.symbol] += quantity
    end
  
    def remove_stock(stock, quantity)
		if @holdings[stock.symbol] >= quantity
			@holdings[stock.symbol] -= quantity
			@holdings.delete(stock.symbol) if @holdings[stock.symbol].zero?
		else
			raise "Not enough stock holdings to sell!"
		end
    end
  
    def display_holdings
		puts "No Holdings" if @holdings.empty?
		@holdings.each { |symbol, qty| puts "#{symbol}: #{qty}" }
    end
end
  