class PriorityQueue
    def initialize(&comparator)
      @queue = []
      @comparator = comparator
    end
  
    def push(order)
      @queue << order
      @queue.sort!(&@comparator)
    end
  
    def pop
      @queue.shift
    end
  
    def peek
      @queue.first
    end
  
    def empty?
      @queue.empty?
    end
end
