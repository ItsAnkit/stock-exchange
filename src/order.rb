class Order
    attr_accessor :quantity
    attr_reader :user, :type, :price, :timestamp, :stock

    def initialize(user, type, price, quantity, stock)
        @user = user
        @type = type       # :buy or :sell
        @price = price
        @quantity = quantity
        @timestamp = Time.now
        @stock = stock
    end

    def to_s
        "#{type.capitalize} Order | User: #{user.name} | Price: #{price} | Quantity: #{quantity} | Stock: #{stock}"
    end
end
