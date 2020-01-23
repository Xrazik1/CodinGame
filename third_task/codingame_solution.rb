# Auto-generated code below aims at helping you parse
# the standard input according to the problem statement.

n, k = gets.split(" ").collect {|x| x.to_i}

# Write an action using puts
# To debug: STDERR.puts "Debug messages..."

result      = []
sum_members = Array(1..n)

1.upto(n) do |index|
  combos = sum_members.repeated_permutation(index).to_a
end
