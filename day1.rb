def input
  <<-IN
L1, L5, R1, R3, L4, L5, R5, R1, L2, L2, L3, R4, L2, R3, R1, L2, R5, R3, L4, R4, L3, R3, R3, L2, R1, L3, R2, L1, R4, L2, R4, L4, R5, L3, R1, R1, L1, L3, L2, R1, R3, R2, L1, R4, L4, R2, L189, L4, R5, R3, L1, R47, R4, R1, R3, L3, L3, L2, R70, L1, R4, R185, R5, L4, L5, R4, L1, L4, R5, L3, R2, R3, L5, L3, R5, L1, R5, L4, R1, R2, L2, L5, L2, R4, L3, R5, R1, L5, L4, L3, R4, L3, L4, L1, L5, L5, R5, L5, L2, L1, L2, L4, L1, L2, R3, R1, R1, L2, L5, R2, L3, L5, L4, L2, L1, L2, R3, L1, L4, R3, R3, L2, R5, L1, L3, L3, L3, L5, R5, R1, R2, L3, L2, R4, R1, R1, R3, R4, R3, L3, R3, L5, R2, L2, R4, R5, L4, L3, L1, L5, L1, R1, R2, L1, R3, R4, R5, R2, R3, L2, L1, L5
  IN
end

class TakeMeThere
  FACINGS = [:north, :east, :south, :west]

  def initialize
    @facing = :north
    @offsets = {north: 0,
                south: 0,
                east: 0,
                west: 0}
  end

  def move!(command)
    turn, walk_length = parse_command(command)
    change_facing(turn)
    walk(walk_length)
  end

  COMMAND_REGEX = /([LR])([\d]+)/
  def parse_command(command)
    match = COMMAND_REGEX.match(command)
    return match[1], match[2].to_i
  end

  def change_facing(turn)
    @facing = new_facing(turn)
  end

  def walk(distance)
    @offsets[@facing] += distance
  end

  def offset_distance
    (@offsets[:north] - @offsets[:south]).abs +
    (@offsets[:east] - @offsets[:west]).abs
  end

  protected

  def new_facing(turn)
    offset = case turn
    when 'L'
      -1
    when 'R'
      1
    end
    idx = (FACINGS.index(@facing)+offset) % FACINGS.length
    FACINGS[idx]
  end

end

mapper = TakeMeThere.new
input.chomp.split(', ').each do |command|
  mapper.move! command
end
puts "Distance walked: #{mapper.offset_distance}"
