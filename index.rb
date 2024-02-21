board = Array.new(3) {Array.new(3, ' ')}


def init_board(board)
    board.each_with_index do |row, row_index|
        row.each_with_index do |column, column_index|
            print "#{row_index}#{column_index} | ".chomp
        end
        puts "\n"
    end 
end

def update_board(index)
    x = index[0].to_i
    y = index[1].to_i
    puts x
    puts y
end

def check_player_input(input)
    allowed_index = [00,01,02,10,11,12,20,21,22]
    if allowed_index.include?(input)
        #check if its already been used
    else
        false
    end
end

def get_index(player)
    puts "#{player}, please enter your location: "
    index = gets.chomp
    index
end

def play_game(board)
    any_winner = false
    playerX = true
    used_index = []
    puts "Here is the location index of the board: "
    puts init_board(board)

    while !any_winner
        if(playerX)
            index = get_index("Player XX")
            can_continue = check_player_input(index, used_index)
            if can_continue
                playerX = false
            else
                puts "Please put a valid index number."
                puts init_board(board)
            end
        else
            player_turn("Player OO")
            playerX = true
        end
    end
end

play_game(board)



