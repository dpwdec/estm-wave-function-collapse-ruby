require 'colorize'

# this program prints the names of the all the possible colorize colors
# in the color that they describe
String.colors.each do |color|
  break if color == :default
  puts color.to_s.upcase.send(color)
end
