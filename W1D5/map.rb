class Map

  def initialize
    @my_map = []
  end

  def find_key_index(key)
    @my_map.each_index { |i| return i if @my_map[i].include?(key) }
  end

  def set(key, value)
    if @my_map.none? {|sub_array| sub_array[0] == key }
      @my_map << [key, value]
    else
      @my_map[find_key_index(key)] = [key, value]
    end
  end

  def get(key)
    #gets key,value pair as [key, value]
    @my_map[find_key_index(key)]
  end

  def delete(key)
    #deletes the [key, value] array
    @my_map.delete_at(find_key_index(key))
  end

  def show
    @my_map
  end
end

the_map = Map.new

#Adding three k,v pairs

the_map.set("A", 1)
the_map.set("B", 2)
the_map.set("C", 3)

#Show @my_map
p the_map.show

#Update ["B", 2] pair with a new value
the_map.set("B", 5)

#Get the pair with key "B"
the_map.get("B")

#Delete the pair with key "A"
the_map.delete("A")

#Show the latest version of @my_map
p the_map.show