# frozen_string_literal: true

class TuringMachine
  STOP_STATE = 'HALT'

  def initialize(params)
    @tape            = Array.new(params[:tape_length], 0)
    @head_position   = params[:head_position]
    @current_state   = params[:state]
    @actions         = params[:actions]
    @actions_counter = 0
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

test_params = {
  tape_length: 4,
  head_position: 0,
  state: 'A',
  actions: {
    'A' => [
      {
        write_value: 1,
        move_to: 'R',
        to_state: 'B'
      },
      {
        write_value: 1,
        move_to: 'R',
        to_state: 'HALT'
      }
    ],
    'B' => [
      {
        write_value: 1,
        move_to: 'L',
        to_state: 'A'
      },
      {
        write_value: 1,
        move_to: 'R',
        to_state: 'B'
      }
    ]
  }
}

machine = TuringMachine.new(test_params)

