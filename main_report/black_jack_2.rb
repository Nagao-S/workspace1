# プレイヤークラス
class Human
  attr_accessor :card_in_hand_num, :name
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

# Humanクラスを継承したPlayerクラス
class Player < Human
  attr_reader :over_card_in_hand_num
  attr_accessor :over_card_in_hand_num

  def initialize(name)
    super(name)
    @over_card_in_hand_num = false
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

      puts 'カードを引きますか？(Y/N)'
      judge_draw = gets.chomp

      break if judge_draw == 'N'

      draw_card(card)
    end

    self.over_card_in_hand_num = true if card_in_hand_num > 21

    self.card_in_hand_num = ace_include if ace
  end
end

# Playerクラスを継承したCpuクラス

class Cpu < Player
  def initialize
    super('CPU')
  end

  def action_turn_come(card)
    puts 'CPUの手番です'
    loop do
      print show_score

      if card_in_hand_num >= 21
        puts "#{name}の現在の得点は#{card_in_hand_num}なのでこれ以上カードは引けません"
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
    condition1 = card_in_hand_num < 17 && card_in_hand_num < player.card_in_hand_num

    condition2 = ace_include < 17 && ace_include < player.card_in_hand_num if ace

    condition1 = true if condition2

    condition1
  end
end

# 各53枚で一組のデッキを作成する
class Card
  attr_reader :deck

  def initialize
    @deck = [['スペード', (1..13).to_a], ['クラブ', (1..13).to_a], ['ダイヤ', (1..13).to_a], ['ハート', (1..13).to_a]]
  end
end

# ブラックジャックゲーム
class Game_Black_Jack
  def initialize(player, dealer, card)
    @player = player
    @dealer = dealer
    @card = card
    @cpu = nil
    @cpu_participation = false
  end

  def start
    puts 'ブラックジャックを開始します'

    judge_add_cpu

    if @cpu_participation
      puts 'ディーラーとあなたとCPUの3人で行います'
    else
      puts 'ディーラーとあなたの2人で行います'
    end

    2.times do
      @player.draw_card(@card)
    end

    if @cpu_participation
      @cpu = Cpu.new
      2.times do
        @cpu.draw_card(@card)
      end
    end

    2.times do
      @dealer.draw_card(@card)
    end

    @player.action_turn_come(@card)

    @cpu.action_turn_come(@card) if @cpu_participation

    @dealer.show_card

    @dealer.action_turn_come(@player, @card)

    show_final_score

    game_judge_win_lose_even

    puts 'ブラックジャックを終了します'
  end

  # CPUがゲームに参加しているかの判定
  def judge_add_cpu
    puts 'CPUを入れて行いますか？(Y/N)'
    judge_add_cpu = gets.chomp
    return unless judge_add_cpu == 'Y'

    @cpu_participation = true
  end

  # プレイヤー、CPU及びディーラーの最終スコアの表示
  def show_final_score
    puts "#{@player.name}の得点は#{@player.card_in_hand_num}です"
    puts "#{@cpu.name}の得点は#{@cpu.card_in_hand_num}です" if @cpu_participation
    puts "#{@dealer.name}の得点は#{@dealer.card_in_hand_num}です"
  end

  # ゲームの勝敗判定
  def game_judge_win_lose_even
    if (@player.card_in_hand_num > @dealer.card_in_hand_num || @dealer.card_in_hand_num > 21) && !@player.over_card_in_hand_num

      puts "#{@player.name}の勝ちです！"

    elsif @player.card_in_hand_num == @dealer.card_in_hand_num
      puts '引き分けです'

    else
      puts "#{@player.name}の負けです"

    end

    return unless @cpu_participation

    if (@cpu.card_in_hand_num > @dealer.card_in_hand_num || @dealer.card_in_hand_num > 21) && !@cpu.over_card_in_hand_num
      puts "#{@cpu.name}の勝ちです！"

    elsif @cpu.card_in_hand_num == @dealer.card_in_hand_num
      puts '引き分けです'

    else
      puts "#{@cpu.name}の負けです"

    end
  end
end

card = Card.new
player1 = Player.new('あなた')
dealer = Dealer.new
game = Game_Black_Jack.new(player1, dealer, card)
game.start
