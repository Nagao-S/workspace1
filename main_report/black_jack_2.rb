# ブラックジャックゲームクラス
class Game_Black_Jack
  def initialize(player, dealer, card)
    @player = player
    @dealer = dealer
    @card = card
    @cpu = nil
    @cpu_participation = false
  end

  def start_game
    puts 'ブラックジャックを開始します'

    judge_add_cpu

    if @cpu_participation
      puts 'ディーラーとあなたとCPUの3人で行います'
    else
      puts 'ディーラーとあなたの2人で行います'
    end

    loop do
      @player.show_cash

      @player.bet_cash
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

      end_game
    end
  end

  # CPUがゲームに参加しているかの判定
  def judge_add_cpu
    puts 'CPUを入れて行いますか？(Y/N)'
    judge_add_cpu = gets.chomp.upcase
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
    if @player.over_card_in_hand_num || @player.surrender || (@player.card_in_hand_num < @dealer.card_in_hand_num && @dealer.card_in_hand_num <= 21)
      puts "#{@player.name}の負けです！"
    elsif @player.card_in_hand_num > @dealer.card_in_hand_num || @dealer.card_in_hand_num > 21
      puts "#{@player.name}の勝ちです！"
      @player.cash += @player.desired_bet_cash * 2
    else
      puts '引き分けです'
      @player.cash += @player.desired_bet_cash
    end
    return unless @cpu_participation

    if !(@cpu.over_card_in_hand_num || @cpu.surrender) || (@cpu.card_in_hand_num < @dealer.card_in_hand_num && @dealer.card_in_hand_num <= 21)
      puts "#{@cpu.name}の負けです"
    elsif (@cpu.card_in_hand_num > @dealer.card_in_hand_num || @dealer.card_in_hand_num > 21) && !@cpu.over_card_in_hand_num
      puts "#{@cpu.name}の勝ちです！"
    else
      puts '引き分けです'
    end
  end

  # ゲームの継続判定
  def end_game
    if @player.cash != 0
      puts 'ゲームを続けますか？(Y/N)'
      continue_game = gets.chomp.upcase
    else
      puts '持ち点数が0になりました。'
      continue_game == 'N'
    end

    if continue_game == 'Y'
      @card = Card.new
      reset_game
      start_game
    else
      puts 'ブラックジャックを終了します'
      exit
    end
  end

  # ゲームのリセットを行う
  def reset_game
    @player.card_in_hand_num = 0
    @player.amount = 0
    @player.over_card_in_hand_num = false
    @player.surrender = false

    @dealer.card_in_hand_num = 0
    @dealer.amount = 0

    return unless @cpu_participation

    @cpu.card_in_hand_num = 0
  end
end
