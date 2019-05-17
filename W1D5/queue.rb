class Queue
  attr_accessor :my_queue
  def initialize
    @my_queue = []
  end

  def enqueue(el)
    @my_queue.unshift(el)
  end

  def dequeue
    @my_queue.pop
  end

  def peek
    @my_queue.last
  end
end

#initialize the queue
pizza_queue = Queue.new

# Adding 3 person to the line. First Jack, then Dorothy, then Darren.
pizza_queue.enqueue("Jack")
pizza_queue.enqueue("Dorothy")
pizza_queue.enqueue("Darren")

# Display the line
p pizza_queue.my_queue

# Peek (First person in line)
p pizza_queue.peek #=> "Jack"

# FIFO

p pizza_queue.dequeue #=> "Jack"
p pizza_queue.dequeue #=> "Dorothy"
p pizza_queue.dequeue #=> "Darren"
