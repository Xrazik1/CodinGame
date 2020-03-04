STDOUT.sync = true # DO NOT REMOVE
# Auto-generated code below aims at helping you parse
# the standard input according to the problem statement.

SPLASH_RADIUS = 4

class Enemy
  attr_reader :number
  attr_accessor :x,
                :y

  def initialize(x, y)
    @x      = x
    @y      = y
  end
end

class Map
  attr_reader   :max_width,
                :max_height,
                :min_width,
                :min_height

  def initialize(max_width, max_height)
    @max_width  = max_width
    @max_height = max_height
    @min_width  = @min_height = 0
  end
end

class Thor
  attr_accessor :enemies,
                :strikes
  attr_reader   :x,
                :y

  def initialize(x, y, map)
    @x             = x
    @y             = y
    @enemies       = []
    @strikes       = nil
    @enemies_count = nil
    @move          = 'WAIT'
    @map           = map
  end

  def make_move
    if @enemies.count == enemies_in_affected_area(@x, @y).count
      @move = 'STRIKE'
    else
      get_best_move
    end

    puts @move
  end

  def scan_enemies
    @enemies.clear
    @strikes, @enemies_count = gets.split(' ').collect(&:to_i)

    while @enemies.count < @enemies_count
      x, y = gets.split(' ').map(&:to_i)
      @enemies << Enemy.new(x, y)
    end
  end

  private

  def get_best_move
    barycenter = define_barycenter
    x = barycenter[:x]
    y = barycenter[:y]

    if enemies_nearby(@x, @y).empty?
      @move = get_direction(x, y)

      new_coords = change_coordinates(@move, @x, @y)

      @x = new_coords[:x]
      @y = new_coords[:y]
    else
      avoid_enemies
    end
  end

  def define_barycenter
    center_x = center_y = 0

    @enemies.each do |enemy|
      center_x += enemy.x
      center_y += enemy.y
    end

    center_x /= enemies.count
    center_y /= enemies.count

    { x: center_x, y: center_y }
  end

  def get_direction(center_x, center_y)
    if center_x > @x
      return 'SE' if center_y > @y
      return 'NE' if center_y < @y
      return 'E'  if center_y == @y
    elsif center_x < @x
      return 'SW' if center_y > @y
      return 'NW' if center_y < @y
      return 'W'  if center_y == @y
    elsif center_x == @x
      return 'S' if center_y > @y
      return 'N' if center_y < @y
      return 'WAIT' if center_y == @y
    end
  end

  def change_coordinates(direction, x, y)
    case direction
    when 'E'
      x += 1
    when 'W'
      x -= 1
    when 'S'
      y += 1
    when 'N'
      y -= 1
    when 'NE'
      x += 1
      y -= 1
    when 'SE'
      x += 1
      y += 1
    when 'SW'
      x -= 1
      y += 1
    when 'NW'
      x -= 1
      y -= 1
    end

    return { x: x, y: y }
  end

  def distance(coords_1, coords_2)
    return (coords_1[:x] - coords_2[:x]).abs + (coords_1[:y] - coords_2[:y]).abs
  end

  def free_directions
    directions = []

    directions << get_next_step_info('W')  if  @x < @map.max_width
    directions << get_next_step_info('E')  if  @x > @map.min_width
    directions << get_next_step_info('N')  if  @y < @map.max_height
    directions << get_next_step_info('S')  if  @y > @map.min_height
    directions << get_next_step_info('NE') if (@x < @map.max_width) && (@y > @map.min_height)
    directions << get_next_step_info('SE') if (@x < @map.max_width) && (@y < @map.max_height)
    directions << get_next_step_info('NW') if (@x > @map.min_width) && (@y > @map.min_height)
    directions << get_next_step_info('SW') if (@x > @map.min_width) && (@y > @map.min_height)

    free = directions.select do |direction|
      x = direction[:coordinates][:x]
      y = direction[:coordinates][:y]

      enemies_nearby(x, y).empty?
    end

    free
  end

  def avoid_enemies
    directions     = free_directions

    best_distance  = 0
    best_direction = { name: '', enemies_close: 0, coordinates: {x: 0, y: 0} }
    barycenter     = define_barycenter
    @move          = 'STRIKE'

    directions.each do |direction|
      if (direction[:enemies_close] > best_direction[:enemies_close]) ||
         ((direction[:enemies_close] == best_direction[:enemies_close]) && distance(direction[:coordinates], barycenter) > best_distance)
      then
        best_direction = direction
        best_distance  = distance(best_direction[:coordinates], barycenter)

        @move          = best_direction[:name]
      end
    end

    @x = best_direction[:coordinates][:x] unless @move == 'STRIKE'
    @y = best_direction[:coordinates][:y] unless @move == 'STRIKE'
  end

  def get_next_step_info(direction)
    new_coords    = change_coordinates(direction, @x, @y)
    enemies_close = enemies_in_affected_area(new_coords[:x], new_coords[:y]).count

    {
      name: direction,
      enemies_close: enemies_close,
      coordinates: new_coords
    }
  end

  def enemies_in_affected_area(x, y)
    @enemies.select { |enemy| ((enemy.x - x).abs <= SPLASH_RADIUS) && ((enemy.y - y).abs <= SPLASH_RADIUS) }
  end

  def enemies_nearby(x, y)
    @enemies.select { |enemy| (enemy.x - x).abs <= 1 && (enemy.y - y).abs <= 1 }
  end
end

tx, ty = gets.split(' ').collect(&:to_i)

map  = Map.new(40, 18)
thor = Thor.new(tx, ty, map)

# game loop
loop do
  thor.scan_enemies
  thor.make_move
  # The movement or action to be carried out: WAIT STRIKE N NE E SE S SW W or N
end
