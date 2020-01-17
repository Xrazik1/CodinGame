# frozen_string_literal: true



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


