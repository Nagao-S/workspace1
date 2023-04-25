# frozen_string_literal: true

require_relative 'human'

# Humanクラスを継承したDealerクラス
class Dealer < Human
  def initialize
    super('ディーラー')
  end

  # カードを1枚引くメソッドを親クラスから呼び出し、引いたカードの詳細を表示
  # また、2枚目に引いたカードの詳細は表示しない
  def draw_card(card)
    super(card)
    if @amount == 2
      puts "#{@name}の引いた#{@amount}枚目のカードはわかりません"
    else
      puts "#{@name}の引いたカードは#{@card_mark}の#{@card_num}です"
    end
  end

  # 2枚目に引いたカードの詳細を表示する
  def show_card
    puts "#{@name}が引いた#{@amount}枚目のカードは#{@card_mark}の#{@card_num}でした"
  end

  # 現在の自身のスコアを表示する。また、Aを引いていた場合はAを1とした場合と11にした場合の２通りを表示
  # ただし、Aを11にした場合にスコアが21を超える場合はその限りではない
  def show_score
    print "#{@name}の現在の得点は"
    if @ace
      @ace_include = @card_in_hand_num + 10
      if @ace_include <= 21 || ace_include >= 17
        @card_in_hand_num = @ace_include
        @ace = false
      elsif @ace_include < 17
        print "#{@ace_include}もしくは"
      else
        @ace = false
      end
    end
    puts "#{@card_in_hand_num}です。"
  end

  # ディーラーの手番が来た際の動作
  def  action_turn_come(player, card)
    if ace
      card_in_hand_num + 10
    else
      card_in_hand_num
    end

    while condition(player)
      show_score
      draw_card(card)
    end
  end

  # ディーラーがAを持っているかの判定
  def condition(player)
    condition1 = card_in_hand_num < 17 && player.card_in_hand_num <= 21

    condition2 = ace_include < 17 && ace_include < player.card_in_hand_num if ace

    condition1 = true if condition2

    condition1
  end
end
