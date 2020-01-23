# https://www.codingame.com/training/hard/simplify-selection-ranges
# All the tests has successfully passed

# Auto-generated code below aims at helping you parse
# the standard input according to the problem statement.

# Преобразовать два вводимых числа-строки в массив из чисел
n, k = gets.split(" ").collect {|x| x.to_i}

# Write an action using puts
# To debug: STDERR.puts "Debug messages..."

result      = []
sum_members = Array(1..n)

# Удаление из возможной комбинации количества конфет, которое не влезает Терри в рот за один раз.
def remove_too_many_candies(combos, max)
  combos.select do |combo|
    combo.select { |candies| candies > max }.empty?
  end
end

# Удаление комбинпций, которые не суммируются в общее число имеющихся у Терри конфет.
def remove_incorrect_sum(combos, sum)
  combos.select { |combo| combo.sum == sum }
end

# Цикл, длинной со всем количеством конфет от 1 до имеющегося количества конфет

1.upto(n) do |index|
  # Метод repeated_combinations первым аргументом принимает длинну комбинаций
  # Максимальная длина комбинаций будет равна имеющемуся количеству конфет у Терри,
  # так как (к примеру) при количестве конфет равному 5, самая длинная комбинация будет
  # [1, 1, 1, 1, 1] и не длиннее.
  combos = sum_members.repeated_permutation(index).to_a

  combos = remove_incorrect_sum(combos, n)
  combos = remove_too_many_candies(combos, k)

  result << combos unless combos.empty?
end

# Раскрыть один уровень массивов, так как result хранит [[[1, 2], [2, 1]], [[1, 1, 1]]]
# и имеет 3 уровня массивов
# Отсортировать все комбинации по возрастанию
result.flatten(1).sort.each do |combo|
  # Преобразовать комбинацию вида [1, 1, 1] в строку '1 1 1'
  combo = combo.join(' ')
  puts combo
end
