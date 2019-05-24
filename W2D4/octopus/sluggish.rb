require 'benchmark'
require 'byebug'

fishes = ['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh']

#SLUGGISH_OCTOPUS

def sluggish(arr)
  longest_fish = arr.first
  arr.each do |el1|
    arr.each do |el2|
      if el2.length > el1.length
        longest_fish = el2
      end
    end
  end
  longest_fish
end

#--------------------------------------#

##MERGE_SORT - DOMINANT_OCTOPUS || [ n log n search]
require 'benchmark'

class Array
  def merge_sort(&prc)
    prc ||= proc { |x, y| x <=> y }

    return self if count <= 1

    midpoint = count / 2
    sorted_left = take(midpoint).merge_sort(&prc)
    sorted_right = drop(midpoint).merge_sort(&prc)

    Array.merge(sorted_left, sorted_right, &prc)
  end

  private

  def self.merge(left, right, &prc)
    merged = []

    until left.empty? || right.empty?
      case prc.call(left.first, right.first)
      when -1
        merged << left.shift
      when 0
        merged << left.shift
      when 1
        merged << right.shift
      end
    end

    merged.concat(left)
    merged.concat(right)
    merged
  end
end

def dominant(fishes)
  prc = proc { |x, y| y.length <=> x.length }
  fishes.merge_sort(&prc)[0]
end

#--------------------------------------#

# CLEVER_OCTOPUS O(n) linear
def clever(arr)
  longest_fish = arr[0]

  arr.each do |el|
    longest_fish = el if el.size > longest_fish.size
  end

  longest_fish
end

#--------------------------------------#

Benchmark.bm(25) do |x|
  x.report('sluggish_octopus:') { 1_000_000.times do sluggish(fishes) end}
  x.report('dominant_octopus') { 1_000_000.times do dominant(fishes) end}
  x.report('clever_octopus:  ') { 1_000_000.times do clever(fishes) end}
end
