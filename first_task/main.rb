# frozen_string_literal: true

class TuringMachine
  def initialize(params)
    @tape            = Array.new(params[:tape_length], 0)
    @head_position   = params[:head_position]
    @current_state   = params[:state]
    @actions         = params[:actions]
    @actions_counter = 0
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


