depths = File.readlines('input.txt').map(&:to_i)
depth_increases = depths.each_with_index.count { |depth, i|  depth > depths[i-1]}
puts depth_increases
