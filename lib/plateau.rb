class Plateau
  attr_reader :upper_x, :upper_y, :rovers

  def initialize(upper_x, upper_y)
    @upper_x = Integer(upper_x) rescue (raise "Plateau upper_x (#{upper_x}) is invalid")
    @upper_y = Integer(upper_y) rescue (raise "Plateau upper_y (#{upper_y}) is invalid")
    @rovers = []
  end

  def valid_coordinates?(x, y)
    x >= 0 && x <= upper_x && y >= 0 && y <= upper_y
  end

  def create_rover(*args)
    rover = Rover.new(self, *args)
    @rovers << rover
    rover
  end

  def rover_positions
    @rovers.map(&:to_s).join("\n\n")
  end
end
