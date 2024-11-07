class Stock
    attr_accessor :symbol, :price
  
    def initialize(symbol, price)
        @symbol = symbol
        @price = price
    end
end
