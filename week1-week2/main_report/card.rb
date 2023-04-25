# frozen_string_literal: true

# 各53枚で一組のデッキを作成する
class Card
  attr_reader :deck

  def initialize
    @deck = [['スペード', (1..13).to_a], ['クラブ', (1..13).to_a], ['ダイヤ', (1..13).to_a], ['ハート', (1..13).to_a]]
  end
end
