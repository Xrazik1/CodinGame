# https://www.codingame.com/training/hard/simplify-selection-ranges


# Auto-generated code below aims at helping you parse
# the standard input according to the problem statement.

numbers = gets.chomp.tr('[]', '').split(',').map(&:to_i).sort

# Write an action using puts
# To debug: STDERR.puts "Debug messages..."

def create_range_string(array)
  "#{array.first}-#{array.last}"
end

ranges = numbers.chunk_while { |current_n, next_n| (current_n + 1) == next_n }

result = ranges.map do |range|
  range.size < 3 ? range : create_range_string(range)
end

puts result.flatten.join(',')
