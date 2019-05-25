class LRUCache
  # creates a LRUCache object with
  def initialize(size)
    @size = size
    @cache = {}
  end

  def count
    # returns number of elements currently in cache
    @cache.length
  end

  def add(ele)
    last_element = nil
    # adds element to cache according to LRU principle

    if self.include?(ele) 
      return ele
      # self.add(ele)
      # last_element = ele
    else
      if self.count >= @size
        self.delete(last_element)
        self.push(ele)
        last_element = ele
      else
        self.push(ele)
        last_element = ele
      end
    end
  end

  def show
    # shows the items in the cache, with the LRU item first
    p self
  end

  private

  # helper methods go here!
end

johnny_cache = LRUCache.new(4)
p johnny_cache

johnny_cache.add('I walk the line')
johnny_cache.add(5)
johnny_cache.count # => returns 2
johnny_cache.add([1, 2, 3])
johnny_cache.add(5)
johnny_cache.add(-5)
johnny_cache.add(a: 1, b: 2, c: 3)
johnny_cache.add([1, 2, 3, 4])
johnny_cache.add('I walk the line')
johnny_cache.add(:ring_of_fire)
johnny_cache.add('I walk the line')
johnny_cache.add(a: 1, b: 2, c: 3)
johnny_cache.show # => prints [[1, 2, 3, 4], :ring_of_fire, "I walk the line", {:a=>1, :b=>2, :c=>3}]



