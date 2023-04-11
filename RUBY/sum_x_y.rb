def sum_x_y(x,y)
  sum = 0
  (x..y).each do |i|
    sum += i
  end
  puts sum
end

sum_x_y(4,10)