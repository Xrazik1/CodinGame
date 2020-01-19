# https://www.codingame.com/training/hard/simplify-selection-ranges
# All the tests are successfully passed

# Auto-generated code below aims at helping you parse
# the standard input according to the problem statement.

# Удаляет скобки по бокам у результата ввода, разбивает строку по запятой на массив
# Преобразует каждый эелемент массива в числовое значение, сортирует массив по возрастанию
numbers = gets.chomp.tr('[]', '').split(',').map(&:to_i).sort

# Write an action using puts
# To debug: STDERR.puts "Debug messages..."

def create_range_string(array)
  "#{array.first}-#{array.last}"
end

# Проходит по всему массиву чисел, добавляет в отдельный массив до тех пор,
# пока текущее число + 1 равняется следующему числу, иначе закрывает массив, и открывает новый.
ranges = numbers.chunk_while { |current_n, next_n| (current_n + 1) == next_n }

# Проходит по массиву с диапазонами и в случае если встречается диапазон
# длинной больше чем 3, заменяет его на строку
result = ranges.map do |range|
  range.size < 3 ? range : create_range_string(range)
end

# Раскарывает все массивы внутри массива result и преобразует в строку, добавляя , между числами
puts result.flatten.join(',')
