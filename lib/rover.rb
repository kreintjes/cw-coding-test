class Rover
  ORIENTATIONS = %w(N E S W)

  attr_reader :plateau, :x, :y, :o

  def initialize(plateau, x, y, o)
    @plateau = plateau

    @x = Integer(x) rescue (raise "Rover x (#{x}) is invalid")
    @y = Integer(y) rescue (raise "Rover y (#{y}) is invalid")
    raise "Rover coordinates (#{@x}, #{@y}) are invalid" unless @plateau.valid_coordinates?(@x, @y)

    @o = o
    raise "Rover orientation (#{@o}) is invalid" unless ORIENTATIONS.include?(@o)
  end

  def move(instruction)
    case instruction
    when 'M'
      move_forward
    when 'L'
      rotate_left
    when 'R'
      rotate_right
    else
      raise "Invalid Rover instruction (#{instruction}) given"
    end
  end

  def to_s
    "#{x} #{y} #{o}"
  end

  private

  def move_forward
    case o
    when 'N'
      @y += 1
    when 'E'
      @x += 1
    when 'S'
      @y -= 1
    when 'W'
      @x -= 1
    end

    raise "Houston, we have a problem: we just fell off the plateau" unless @plateau.valid_coordinates?(@x, @y)
  end

  def rotate_left
    rotate(-1)
  end

  def rotate_right
    rotate(1)
  end

  def rotate(step)
    index = ORIENTATIONS.index(o)
    new_index = (index + step) % ORIENTATIONS.size
    @o = ORIENTATIONS[new_index]
  end
end
