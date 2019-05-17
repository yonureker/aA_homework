class Stack
  #follow LIFO (Last-In-First-Out) principle
  attr_reader :the_stack
  def initialize
    @the_stack = []
  end

  def push(el)
    @the_stack.push(el)
  end

  def pop
    @the_stack.pop
  end

  def peek
    @the_stack.last
  end
end

# initialize the stack
new_stack = Stack.new
# Add three passengers
new_stack.push("first passenger")
new_stack.push("second passenger")
new_stack.push("third passenger")
# Display the stack
p new_stack.the_stack
# Peek the last passenger in the stack
p new_stack.peek
# Last passenger gets out first
p new_stack.pop