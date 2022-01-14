depths = File.readlines('input.txt').map(&:to_i)

depths_by_groups_of_3 = depths[0..-3].each_with_index.map do |depth, i|
  depth + depths[i+1] + depths[i+2]
end

depth_increases = depths_by_groups_of_3.each_with_index.count do |depth, i|
  depth > depths_by_groups_of_3[i-1]
end
puts depth_increases
