require "scanf"
require "pp"

data = File.read "eye2.ai"
data.split("\r").each do |line|
  if line =~ /m$/
    # Move
    x, y = *line.scanf("%f %f")
    puts "[path moveToPoint:NSMakePoint(#{x}, #{y})];"
  elsif
    line =~ / c|C$/
    # Curve
    c1x, c1y, c2x, c2y, x, y = *line.scanf("%f "*6)
    puts "[path curveToPoint:NSMakePoint(#{x}, #{y}) controlPoint1:NSMakePoint(#{c1x}, #{c1y}) controlPoint2:NSMakePoint(#{c2x}, #{c2y})];"
  elsif line =~ / L$/
    x, y = *line.scanf("%f %f")
    puts "[path lineToPoint:NSMakePoint(#{x}, #{y})];"
  end
end