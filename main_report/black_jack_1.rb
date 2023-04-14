#Humanクラス
class Human 
  attr_reader :card_in_hand_no, :name
  CARD_MARK_ARRAY = ["ハート","クラブ","ダイヤ","スペード"]
  def initialize(name)
    @name = name
    @card_in_hand_no = 0
    @card_no = 0
    @card_mark = ''
    @amount = 0

  end
  
  def draw_card
    @card_no = rand(1...13)
    @card_mark = CARD_MARK_ARRAY[rand(4)]
    @amount += 1
  
    case @card_no
    when 1
      @card_in_hand_no += @card_no
      @card_no = 'A'
      
    when 11
      @card_in_hand_no += 10 
      @card_no = 'J'
    when 12
      @card_in_hand_no += 10 
      @card_no = 'Q'
    when 13
      @card_in_hand_no += 10 
      @card_no = 'K'
    else
      @card_in_hand_no += @card_no 
    end

    if name == "ディーラー" && @amount == 2
      puts "#{@name}の引いた#{@amount}枚目のカードはわかりません"  
    else
      puts "#{@name}の引いたカードは#{@card_mark}の#{@card_no}です"  
    end
  
  end

  def show_card
    puts "#{@name}が引いた#{@amount}枚目のカードは#{@card_mark}の#{@card_no}でした"
    puts "#{@name}の現在の得点は#{@card_in_hand_no}です"
  end

  def show_point
    loop{
      if @card_in_hand_no >= 21
        puts "#{@name}の現在の得点は#{@card_in_hand_no}です"
        break
      end

      puts "#{@name}の現在の得点は#{@card_in_hand_no}です。カードを引きますか？(Y/N)"
      @judge_draw = gets.chomp 
      
      break if @judge_draw == 'N'
      
      draw_card
    }
  end
end

def judge_card(player,dealer)
  
  if player.card_in_hand_no > 21
    puts "#{player.name}の負けです" 

  else

    dealer.show_card

    while dealer.card_in_hand_no < 17 && dealer.card_in_hand_no < player.card_in_hand_no
      dealer.draw_card
      puts "#{dealer.name}の現在の得点は#{dealer.card_in_hand_no}です"
    end
  
    if player.card_in_hand_no > dealer.card_in_hand_no || dealer.card_in_hand_no > 21
      puts "#{player.name}の勝ちです！"
  
    elsif player.card_in_hand_no == dealer.card_in_hand_no
      puts "引き分けです"
    
    else
      puts "#{player.name}の負けです"
    end
  end
  puts "ブラックジャックを終了します"
end


player1 = Human.new("あなた")
dealer = Human.new("ディーラー")
player1.draw_card
player1.draw_card
dealer.draw_card
dealer.draw_card
player1.show_point

judge_card(player1,dealer)







# puts "ブラックジャックを開始します"
# #プレイヤー側がカードを2枚引く

# #プレイヤーが引いたカードが何かを明示（2回繰り返す）

# #ディーラー側がカードを2枚引く

# #ディーラーが引いたカードが何かを明示（ただし2枚目は明示しない）

# puts "ディーラーの引いた2枚目のカードはわかりません"

# #プレイヤーがカードを引くかの選択（Y/N）

# #プレイヤーが引いたカードを明示

# #プレイヤーがカードを引くかの選択（Y/N）（Nを選択するまで繰り返す）

# #ディーラー側で合計が17以上になるまでカードを引く

# #勝敗判定

# puts "ブラックジャックを終了します"




