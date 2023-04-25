# frozen_string_literal: true

require_relative 'human'

# Humanクラスを継承したPlayerクラス
class Player < Human
  attr_accessor :over_card_in_hand_num, :cash, :desired_bet_cash, :surrender

  def initialize(name)
    super(name)
    @cash = 100
    @over_card_in_hand_num = false
    @desired_bet_cash = 0
  end

  # 現在のベットできる持ち点の表示
  def show_cash
    puts 'いくらベットしますか？'
    puts "現在の#{@name}の持ち点は#{@cash}点です"
  end

  # ベットする点数
  def bet_cash
    @desired_bet_cash = 0
    while @desired_bet_cash.zero?
      @desired_bet_cash = gets.chomp.to_i
      if @desired_bet_cash > @cash
        puts "現在#{@name}が賭けられる点数は#{@cash}点までです"
        @desired_bet_cash = 0
      else
        puts "#{@name}の賭けた点数は#{@desired_bet_cash}点です"
        @cash -= desired_bet_cash
      end
    end
  end

  # カードを一枚引くメソッドを親クラスから呼び出し、引いたカードの詳細を表示する
  def draw_card(card)
    super(card)
    puts "#{@name}の引いたカードは#{@card_mark}の#{@card_num}です"
  end

  def action_turn_come(card)
    loop do
      print show_score

      if card_in_hand_num >= 21
        puts "#{name}の現在の得点は#{card_in_hand_num}なのでこれ以上カードは引けません"
        break
      end

      puts 'カードを引く(Y/N)'
      if @amount == 2
        puts 'ダブルダウン(W)'
        puts 'サレンダー(S)'
      end

      judge_draw = gets.chomp.upcase

      case judge_draw
      when 'N'
        break
      when 'Y'
        draw_card(card)
      when 'W'
        if @cash < @desired_bet_cash
          puts '持ち点が足りません'
        else
          @cash -= @desired_bet_cash
          @desired_bet_cash *= 2
          draw_card(card)
          show_score
          break
        end
      when 'S'
        @cash += @desired_bet_cash / 2
        @surrender = true
        break
      end
    end

    self.over_card_in_hand_num = true if card_in_hand_num > 21

    self.card_in_hand_num = ace_include if ace
  end
end
