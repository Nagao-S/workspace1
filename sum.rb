def sum_1_100
  sum = 0
  (1..100).each do |i|
    sum += i
  end
  puts sum
end

sum_1_100()