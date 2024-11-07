require_relative 'priority_queue'

class OrderProcessor

    def initialize()
        @buy_orders = PriorityQueue.new { |a, b| [b.price, a.timestamp] <=> [a.price, b.timestamp] }
        @sell_orders = PriorityQueue.new { |a, b| [a.price, a.timestamp] <=> [b.price, b.timestamp] }
    end

    def add_order(order)
        if order.type == :buy
            @buy_orders.push(order)
        else
            @sell_orders.push(order)
        end
        match_orders
    end

    def match_orders
        while !@buy_orders.empty? && !@sell_orders.empty?
            highest_buy = @buy_orders.peek
            lowest_sell = @sell_orders.peek

            if highest_buy.price >= lowest_sell.price
                execute_order(highest_buy, lowest_sell)
            else
                break
            end
        end
    end

    def execute_order(buy_order, sell_order)
        matched_quantity = [buy_order.quantity, sell_order.quantity].min
        matched_price = sell_order.price

        puts "Executed Trade | Buy User: #{buy_order.user.name} | Sell User: #{sell_order.user.name} | Price: #{matched_price} | Quantity: #{matched_quantity}"

        # Update holdings
        purchase_amount = matched_price*matched_quantity
        return unless buy_order.user.withdraw(purchase_amount)
        buy_order.user.portfolio.add_stock(buy_order.stock, matched_quantity)
        sell_order.user.portfolio.add_stock(sell_order.stock, -matched_quantity)
        sell_order.user.deposit(purchase_amount)
        buy_order.stock.price = matched_price
        adjust_quantities(buy_order, sell_order, matched_quantity)
    end

    def adjust_quantities(buy_order, sell_order, matched_quantity)
        # Adjust remaining quantities
        buy_order.quantity -= matched_quantity
        sell_order.quantity -= matched_quantity

        # Remove fully matched orders
        @buy_orders.pop if buy_order.quantity.zero?
        @sell_orders.pop if sell_order.quantity.zero?
    end
end
