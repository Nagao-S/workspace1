class Human
  attr_accessor :amount, :card_in_hand_num, :name
  attr_reader :amount, :card_mark, :card_num, :judge_draw, :ace, :ace_include

  def initialize(name)
    @card_in_hand_num = 0
    @card_num = 0
    @card_mark = ''
    @amount = 0
    @judge_draw = 'Y'
    @ace = false
    @ace_include = 0
    @name = name
  end

  # カードをデッキから１枚引く
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
      @ace = true
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

  # 現在の自身のスコアを表示する。また、Aを引いていた場合はAを1とした場合と11にした場合の２通りを表示
  # ただし、Aを11にした場合にスコアが21を超える場合はその限りではない
  def show_score
    print "#{@name}の現在の得点は"
    if @ace
      @ace_include = @card_in_hand_num + 10

      if @ace_include == 11
        @card_in_hand_num = @ace_include
      elsif @ace_include < 21
        print "#{@ace_include}もしくは"
      else
        @ace = false
      end
    end
    puts "#{@card_in_hand_num}です。"
  end
end