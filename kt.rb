# frozen_string_literal: true
class Square
    attr_reader :column, :row
    attr_accessor :value
  
    def initialize(column, row, value = " ")
      @column = column
      @row = row
      @value = value
    end
  end
class Chessboard
  def initialize
    for column in 0..7
      for row in 0..7
        Square.new(column, row)
      end
    end
  end

  def knight_moves(initial_location, end_location)
    knight_travels = KnightTree.new(initial_location)
    route = knight_travels.breadth_order_search(end_location)
    puts " You made it in #{route.length - 1} moves! Heres your path:"
    for i in route
      print "#{i}\n"
    end
  end
end
class Knight
    attr_reader :parent, :location, :possible_moves
  
    def initialize(location, parent = nil)
      @location = location
      @column = location[0]
      @row = location[1]
      @possible_moves = possible_moves
      @parent = parent
    end
  
    def possible_moves(column = @column, row = @row)
      result = [
              [column + 2, row + 1], [column + 2, row - 1], 
              [column - 2, row + 1], [column - 2, row - 1],
              [column + 1, row + 2], [column - 1, row + 2],
              [column + 1, row - 2], [column - 1, row - 2]]
      result = result.filter do |location| 
        #Filter out impossible moves e.g out of board moves
        if location[0] < 0 || location[0] > 7 || location[1] < 0 || location[1] > 7
          false
        else
          true
        end
      end
      return result
    end
end
class KnightTree
    def initialize(location)
      @root = Knight.new(location)
    end
  
    def breadth_order_search(end_location)
      queue = [@root]
      current_node = nil
      loop do
        current_node = queue.shift
        if current_node.location == end_location
          break
        end
        #Add all next possible moves into queue
        for i in current_node.possible_moves
          queue.append(Knight.new(i, current_node))
        end
      end
      path = []
      #Find the path that led to destination
      loop do
        path.unshift(current_node.location)
        if current_node.parent.nil?
          break
        end
        current_node = current_node.parent
      end
      path
    end
  end 
x = Chessboard.new
x.knight_moves([3,3],[4,3])
x.knight_moves([0,0],[7,7])
