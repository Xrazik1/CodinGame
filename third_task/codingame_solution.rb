# Auto-generated code below aims at helping you parse
# the standard input according to the problem statement.

n, k = gets.split(" ").collect {|x| x.to_i}

# Write an action using puts
# To debug: STDERR.puts "Debug messages..."

result      = []
sum_members = Array(1..n)

def remove_too_many_candies(combos, max)
  combos.select do |combo|
    combo.select {|candies| candies > max }.empty?
  end
end

def remove_incorrect_sum(combos, sum)
  combos.select { |combo| combo.sum == sum  }
end

1.upto(n) do |index|
  combos = sum_members.repeated_permutation(index).to_a

  combos = remove_incorrect_sum(combos, n)
  combos = remove_too_many_candies(combos, k)

  result << combos unless combos.empty?
end
