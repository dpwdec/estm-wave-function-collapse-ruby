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
    @compatibilities = nil
    @weights = nil
    @output_size = [10, 50]
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
    compatibilities = Set.new
    
    @input_matrix.each_with_index do |row, x|
      row.each_with_index do |cur_tile, y|
         weights[cur_tile] = 0 if !weights.key?(cur_tile)
         weights[cur_tile] += 1
         
         valid_dirs(x, y).each do |dir|
           other_tile = @input_matrix[x + dir[0]][y + dir[1]]
           compatibilities.add([cur_tile, other_tile, dir])
         end
      end
    end
    
    @weights = weights
    @compatibilities = compatibilities
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
  
  # checks whether a specified compatibility exists
  def check(tile_1, tile_2, direction)
    @compatibilities.include?([tile_1, tile_2, direction])
  end
  
  def weights
    @weights
  end
  
  def output_size
    @output_size
  end
  
  def compatibilities
    @compatibilities
  end
end

class Wave
  
  attr_accessor :coefficients
  
  def initialize(model)
    @coefficients = []
    @model = model
  end
  
  def init_coefficients
    weight_keys = @model.weights.keys
    
    @model.output_size[0].times do
      row = []
      @model.output_size[1].times do
        row << weight_keys
      end
      @coefficients << row
    end
  end
end