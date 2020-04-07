require 'colorize'

# Even simpler tiled model, implementation of wave function collapse in Ruby

UP = [0, 1] # -->
#>
#|
LEFT = [-1, 0]
DOWN = [0, -1] # <--
RIGHT = [1, 0]
#|
#>

class Estm
  
  def initialize(input_matrix)
    @input_matrix = input_matrix
  end
  
  # Uses the object's currently defined input matrix.
  # weights --> 
  # corresponds to how frequently a tile appears in the source matrix
  #
  # compatibilities -->
  # contains a unique set of tile relationships in the format:
  # [source_tile, related_tile, direction]
  def parse_example_matrix
    
    weights = Hash.new
    
    @input_matrix.each_with_index do |row, y|
      row.each_with_index do |cur_tile, x|
         weights[cur_tile] = 0 if !weights.key?(cur_tile)
         weights[cur_tile] += 1
      end
    end
    
    return weights, Set.new
  end
  
  # returns possible valid neighbour positions in the matrix
  # dirs -->
  # contains a set of 2D arrays containing offset translation vecotrs
  # to valid neighbours
  def valid_dirs(x, y)
    width = @input_matrix.length
    height = @input_matrix[0].length
    
    dirs = []
    
    dirs << LEFT if x > 0 
    dirs << RIGHT if x < width - 1
    dirs << DOWN if y > 0
    dirs << UP if y < height - 1
    
    return dirs
  end
end