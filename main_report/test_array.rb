class Card
  attr_reader :deck
  def initialize
    @deck = [["スペード",(1..13).to_a],["クラブ",(1..13).to_a],["ダイヤ",(1..13).to_a],["ハート",(1..13).to_a]]
  end
end

def draw_card(card)
  deck = card.deck
  card_array = deck.sample

  card_mark = card_array[0]
  card_array_num = card_array[1]
  card_num = card_array_num.sample
  card_array_num.delete(card_num)

  
  case card_num
  when 1
    
    card_no = 'A'
    
  when 11
    
    card_no = 'J'
  when 12
    
    card_no = 'Q'
  when 13
    card_no = 'K'
  end  
  puts "引いたカードは#{card_mark}の#{card_num}です"  

  # deck.delete(card_array) if card_array_num.empty?
  if card_array_num.empty?
    puts "#{card_mark}がなくなりました"
    deck.delete(card_array)
  end
end

card = Card.new
52.times do
  draw_card(card)
end
