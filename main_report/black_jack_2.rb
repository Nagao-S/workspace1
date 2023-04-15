
#プレイヤークラス
class Human 
  attr_reader :card_in_hand_num,:amount, :card_mark, :card_num, :judge_draw
  def initialize
    @card_in_hand_num = 0
    @card_num = 0
    @card_mark = ''
    @amount = 0
    @judge_draw = 'Y'
  end

  def draw_card(card)
    deck = card.deck
    card_array = deck.sample
    @card_mark = card_array[0]
    card_array_num = card_array[1]
    @card_num = card_array_num.sample
    @amount += 1

    card_array_num.delete(@card_num)
    deck.delete(card_array) if card_array_num.empty?

    case @card_num
    when 1
      
      @card_in_hand_num += @card_num
      @card_num = 'A'
      
    when 11
      @card_in_hand_num += 10 
      @card_num = 'J'
    when 12
      @card_in_hand_num += 10 
      @card_num = 'Q'
    when 13
      @card_in_hand_num += 10 
      @card_num = 'K'
    else
      @card_in_hand_num += @card_num 
    end  
  end

  
end

class Player < Human
  attr_reader :name 
  
  def initialize
    super
    @name = "あなた"
  end

  def draw_card(card)
    super(card)
    puts "#{@name}の引いたカードは#{@card_mark}の#{@card_num}です"  
    
  end

  def show_point
    puts "#{@name}の現在の得点は#{@card_in_hand_num}です。"
  end
end


class Dealer < Human
  attr_reader :name
  
  def initialize
    super
    @name = "ディーラー"
  end
  def draw_card(card)
    super(card)
    if @amount == 2
      puts "#{@name}の引いた#{@amount}枚目のカードはわかりません"  
    else
      puts "#{@name}の引いたカードは#{@card_mark}の#{@card_num}です"  
    end
  end
  
  def show_card
    puts "#{@name}が引いた#{@amount}枚目のカードは#{@card_mark}の#{@card_num}でした"
  end

  def show_point
    puts "#{@name}の現在の得点は#{@card_in_hand_num}です。"
  end
  
end

class Card
  attr_reader :deck
  def initialize
    @deck = [["スペード",(1..13).to_a],["クラブ",(1..13).to_a],["ダイヤ",(1..13).to_a],["ハート",(1..13).to_a]]
  end
end

class Game_Black_Jack
  def start(player,dealer,card)
    puts "ブラックジャックを開始します"

    2.times do
    player.draw_card(card)
    end
    
    2.times do
    dealer.draw_card(card)
    end

    loop{
      if player.card_in_hand_num >= 21
        puts "#{player.name}の現在の得点は#{player.card_in_hand_num}なのでこれ以上カードは引けません"
        break
      end

      print player.show_point
      puts "カードを引きますか？(Y/N)"
      judge_draw = gets.chomp 
      
      break if judge_draw == 'N'

      player.draw_card(card)
    }

    
    if player.card_in_hand_num > 21
      puts "#{player.name}の負けです" 
    else

      dealer.show_card
      while dealer.card_in_hand_num < 17 && dealer.card_in_hand_num <= player.card_in_hand_num

        dealer.show_point
        dealer.draw_card(card)
      end
      puts "#{player.name}の得点は#{player.card_in_hand_num}です"
      puts "#{dealer.name}の得点は#{dealer.card_in_hand_num}です"

      if player.card_in_hand_num > dealer.card_in_hand_num || dealer.card_in_hand_num > 21
        puts "#{player.name}の勝ちです！"

      elsif player.card_in_hand_num == dealer.card_in_hand_num
        puts "引き分けです"

      else
        puts "#{player.name}の負けです"

      end
    end
    puts "ブラックジャックを終了します"
  end
end

card = Card.new
player1 = Player.new
dealer = Dealer.new
game = Game_Black_Jack.new
game.start(player1,dealer,card)