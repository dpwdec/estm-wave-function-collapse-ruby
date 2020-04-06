require 'colorize'

# Even simpler tiled model, implementation of wave function collapse in Ruby

class Estm
  
  def initialize(input_matrix)
    @input_matrix = input_matrix
  end
  
  def parse_example_matrix
    
    weights = Hash.new
    
    @input_matrix.each_with_index do |row, x|
      row.each_with_index do |cur_tile, y|
         weights[cur_tile] = 0 if !weights.key?(cur_tile)
         weights[cur_tile] += 1
      end
    end
    
    return weights, Set.new
  end
end