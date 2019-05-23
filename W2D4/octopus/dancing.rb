require 'benchmark'

tiles_array = ["up", "right-up", "right", "right-down", "down", "left-down", "left",  "left-up" ]
tiles_hash = { "up" => 0 , "right-up" => 1, "right" => 2, "right-down" => 3 , "down" => 4, "left-down" => 5, "left" => 6,  "left-up" => 7 }

def slow_dance(dir, tiles_array)
  tiles_array.each_with_index do |el, idx|
    return idx if el == dir
  end
end

def fast_dance(dir, tiles_hash)
  tiles_hash[dir]
end


Benchmark.bm(7) do |x|
  x.report("hash")  { 1000000.times do fast_dance("down", tiles_hash) end }
  x.report("array") { 1000000.times do slow_dance("down", tiles_array) end}
end

