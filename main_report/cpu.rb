require_relative 'player'

# Playerクラスを継承したCpuクラス
class Cpu < Player
  def initialize
    super('CPU')
  end

  def action_turn_come(card)
    puts "#{@name}の手番です"
    loop do
      print show_score

      if card_in_hand_num >= 21
        puts "#{@name}の現在の得点は#{card_in_hand_num}なのでこれ以上カードは引けません"
        break
      end

      puts 'カードを引きますか？(Y/N)'
      judge_draw = %w[Y N].to_a[rand(2)]
      if card_in_hand_num <= 16
        puts 'Y'
        draw_card(card)

      elsif judge_draw == 'Y'
        puts 'Y'
        draw_card(card)
      else
        puts 'N'
        break
      end
    end

    self.over_card_in_hand_num = true if card_in_hand_num > 21

    self.card_in_hand_num = ace_include if ace
  end
end