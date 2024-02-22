board = Array.new(3) { Array.new(3, ' ') }
used_index = []
playerX = true
no_winner = true

def init_board(board)
  board.each_with_index do |row, row_index|
    row.each_with_index do |_column, column_index|
      print "#{row_index}#{column_index} | "
    end
    puts "\n"
  end
end

def current_board(board, index, playerX)
  x = index[0].to_i
  y = index[1].to_i
  board[x][y] = playerX ? 'X' : 'O'
  draw_board(board)
end

def draw_board(board)
  board.each do |row|
    row.each do |column|
      print "#{column} | "
    end
    puts "\n"
  end
  puts "\n"
end

def check_player_input(input, used_index)
  allowed_index = %w[00 01 02 10 11 12 20 21 22]
  !used_index.include?(input) && allowed_index.include?(input)
end

def get_index(playerX)
  print playerX ? 'Player X, please enter index: ' : 'Player O, please enter index: '
  gets.chomp
end

def check_winner(board, no_winner)
  winning_combinations = [
    %w[00 01 02], %w[10 11 12], %w[20 21 22], # Rows
    %w[00 10 20], %w[01 11 21], %w[02 12 22], # Columns
    %w[00 11 22], %w[20 11 02] # Diagonals
  ]

  winner = nil
  players = %w[X O]

  players.each do |player|
    player_locations = []

    board.each_with_index do |row, row_index|
      row.each_with_index do |cell, column_index|
        player_locations << "#{row_index}#{column_index}" if cell == player
      end
    end
    # p player_locations

    winning_combinations.each do |sets|
      next unless sets.all? { |element| player_locations.include?(element) }

      winner = player
      no_winner = false
      break
    end
  end
  # p   [winner, no_winner]
  [winner, no_winner]
end

def play_game(board, used_index, playerX, no_winner)
  puts 'Here is the location index of the board: '
  init_board(board)

  winner_info = []

  while used_index.length < 9
    index = get_index(playerX)
    if !check_player_input(index, used_index)
      puts 'Please enter a valid index number.'
      init_board(board)
    else
      used_index << index
      current_board(board, index, playerX)
      playerX = !playerX
    end
    winner_info = check_winner(board, no_winner)

    unless winner_info[1]
      puts "Congrats the winner is Player #{winner_info[0]}"
      break
    end
  end

  puts 'There is no winner.' if winner_info[1]
end

play_game(board, used_index, playerX, no_winner)
