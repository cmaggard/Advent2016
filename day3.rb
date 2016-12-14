class Trichecker
  def is_valid?(line)
    vals = get_vals(line)
    vals_possible?(vals)
  end

  LINE_REGEX = /(\d+)\s+(\d+)\s+(\d+)/
  def get_vals(line)
    match = LINE_REGEX.match(line)
    return match[1..3].map(&:to_i)
  end

  def vals_possible?(vals)
    sort_vals = vals.sort
    sort_vals[0] + sort_vals[1] > sort_vals[2]
  end
end

checker = Trichecker.new
num_valid = open("dat/day3.dat").readlines.inject(0) do |acc, tuple|
  if checker.is_valid?(tuple)
    acc + 1
  else
    acc
  end
end

puts "#{num_valid} triangles are valid"
