# https://www.codingame.com/training/hard/turing-machine
# All the tests are successfully passed

# Auto-generated code below aims at helping you parse
# the standard input according to the problem statement.

_, tape_length, head_position = gets.split(' ').collect(&:to_i)
actions = {}
start = gets.chomp
n = gets.to_i
n.times do
  stateactions = gets.chomp
  stateactions = stateactions.split(':')
  state = stateactions[0]

  actions[stateactions[0]] = []
  stateactions = stateactions[1].split(';')

  stateactions.each do |action|
    action = action.split(' ')
    actions[state] << {
      write_value: action[0].to_i,
      move_to: action[1],
      to_state: action[2]
    }
  end
end

# Write an action using puts
# To debug: STDERR.puts "Debug messages..."

class TuringMachine
  STOP_STATE = 'HALT'

  def initialize(params)
    @tape = Array.new(params[:tape_length], 0)
    @head_position = params[:head_position]
    @current_state = params[:state]
    @actions = params[:actions]
    @actions_counter = 0
  end

  def run
    loop do
      return get_report if went_out_of_bounds? || @current_state == STOP_STATE

      current_value = @tape[@head_position]
      new_value     = @actions[@current_state][current_value][:write_value]
      new_direction = @actions[@current_state][current_value][:move_to]
      new_state     = @actions[@current_state][current_value][:to_state]

      write_value(new_value)
      write_direction(new_direction)
      increase_actions_counter
      write_state(new_state)
    end
  end

  private

  def get_report
    handle_out_of_bounds if went_out_of_bounds?

    {
      actions_count: @actions_counter,
      head_position: @head_position,
      tape: @tape
    }
  end

  def move_head_left
    @head_position -= 1
  end

  def move_head_right
    @head_position += 1
  end

  def increase_actions_counter
    @actions_counter += 1
  end

  def write_state(state)
    @current_state = state
  end

  def write_value(value)
    @tape[@head_position] = value
  end

  def write_direction(direction)
    case direction
    when 'R'
      move_head_right
    when 'L'
      move_head_left
    end
  end

  def handle_out_of_bounds
    @head_position = -1         if @head_position.negative?
    @head_position = @tape.size if @head_position > @tape.size - 1
  end

  def went_out_of_bounds?
    return true if @head_position > @tape.size - 1
    return true if @head_position.negative?

    false
  end
end

params = {
  tape_length: tape_length,
  head_position: head_position,
  state: start,
  actions: actions
}

machine = TuringMachine.new(params)

report = machine.run

puts report[:actions_count]
puts report[:head_position]
puts report[:tape].join
