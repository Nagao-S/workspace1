
def calculate(num1, num2, operator)
  if !num1.is_a?(Float) || !num2.is_a?(Float)
    raise ArgumentError, "num1, num2には数値を入力してください"
  end
  if num1 != num1.to_i || num2 != num2.to_i
    raise ArgumentError, "num1, num2には整数を入力してください"
  end
  case operator
  when '+'
    num1 + num2
  when '-'
    num1 - num2
  when '*'
    num1 * num2
  when '/'
    if num2 == 0
      raise ZeroDivisionError, "ゼロによる割り算は許可されていません"
    else
      num1 / num2
    end
  else
    raise ArgumentError, "演算子には+、-、*、/、のいずれかを使用してください"
  end
end

puts "1番目の数値を入力してください:"
num1 = gets.chomp.to_f

puts "2番目の数値を入力してください:"
num2 = gets.chomp.to_f

puts "演算子(+, -, *, /)を入力してください:"
operator = gets.chomp

begin
  result = calculate(num1, num2, operator)
  puts result
rescue ArgumentError => e
  puts e.message
rescue ZeroDivisionError => e
  puts e.message
end