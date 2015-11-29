require_relative 'plateau'
require_relative 'rover'

class Main
  def run(file)
    raise 'No input file given' unless file

    text = File.read(file)
    lines = text.split("\n").reject(&:empty?)
    raise 'Input file is empty or contains only empty lines' if lines.empty?

    # First setup the plateau
    (upper_x, upper_y) = lines.shift.split(' ')
    raise 'Expected two coordinates to setup the plateau' unless upper_x && upper_y
    plateau = Plateau.new(upper_x, upper_y)

    # Then setup the rovers and execute their instructions
    raise 'Not every rover has an instruction line' unless lines.size.even?
    lines.each_slice(2) do |position, instructions|
      (x, y, o) = position.split(' ')
      raise 'Expected two coordinates and orientation to setup rover' unless x && y && o

      rover = plateau.create_rover(x, y, o)
      instructions.chars.each { |i| rover.move(i) }
    end

    puts plateau.rover_positions
  end
end
