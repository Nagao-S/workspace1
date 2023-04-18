require_relative 'spec_helper'

describe Player do
  let(:card) { Card.new }
  let(:player) { Player.new }

  describe '#draw_card' do
    it 'should increase the player hand value' do
      initial_hand_value = player.card_in_hand_num
      player.draw_card(card)
      expect(player.card_in_hand_num).to be > initial_hand_value
    end
  end
end

describe Dealer do
  let(:card) { Card.new }
  let(:dealer) { Dealer.new }

  describe '#draw_card' do
    it 'should increase the dealer hand value' do
      initial_hand_value = dealer.card_in_hand_num
      dealer.draw_card(card)
      expect(dealer.card_in_hand_num).to be > initial_hand_value
    end
  end
end

describe Card do
  let(:card) { Card.new }

  describe '#deck' do
    it 'should have a valid deck of cards' do
      expect(card.deck.length).to eq(4)
      card.deck.each do |suit|
        expect(suit[1].length).to eq(13)
      end
    end
  end
end

describe Game_Black_Jack do
  let(:player) { Player.new }
  let(:dealer) { Dealer.new }
  let(:card) { Card.new }
  let(:game) { Game_Black_Jack.new }

  describe '#condition' do
    it 'should return true if dealer hand value is less than 17 and less than player hand value' do
      allow(player).to receive(:card_in_hand_num).and_return(20)
      allow(dealer).to receive(:card_in_hand_num).and_return(16)
      expect(game.condition(player, dealer)).to be true
    end

    it 'should return false if dealer hand value is greater than or equal to 17' do
      allow(player).to receive(:card_in_hand_num).and_return(20)
      allow(dealer).to receive(:card_in_hand_num).and_return(17)
      expect(game.condition(player, dealer)).to be false
    end

    it 'should return false if dealer hand value is greater than player hand value' do
      allow(player).to receive(:card_in_hand_num).and_return(15)
      allow(dealer).to receive(:card_in_hand_num).and_return(16)
      expect(game.condition(player, dealer)).to be false
    end
  end
end