class VendingMachine
  #初期化
  def initialize(manufacturer_name)
    #企業名
    @manufacturer_name = manufacturer_name
    #自動販売機に入っている金額
    @deposit = 0
    #自動販売機に入っているカップの数
    @stock = 0
  end

  #カップの補充
  def add_cup(amount)
    @stock += amount
    @stock = 100 if @stock > 100
  end

  #コインが入れられたときの挙動
  def deposit_coin(coin)
    @deposit += 100 if coin == 100
  end
  #ボタンが押されたときの挙動
  def press_button(item)
    #選択されたアイテムがコーヒカップの場合
    if item.is_a?(CupCoffee) && @stock != 0 && @deposit >= item.price
      @deposit -= item.price
      @stock -=  1
      item.name
    #選択されたアイテムがコーヒカップ以外の場合
    elsif item.is_a?(Beverage) && @deposit >= item.price
      @deposit -= item.price
      item.name
    elsif item.is_a?(Snack) && @deposit >= item.price
      @deposit -= item.price
      item.name
    else
      ''
    end
  end  

  private

  def press_manufacturer_name
    @manufacturer_name
  end

end

#アイテムクラス
class Item
  attr_reader :name, :price
  def initialize(name,price)
    @name = name
    @price = price
  end
end

#アイテムクラスを継承した飲料クラス
class Beverage < Item
  def initialize(name)
    price = case name
    when 'cider'
      100
    when 'cola'
      150
    else
      raise "None #{name}"
    end
    super(name, price)
  end
end

#アイテムクラスを継承したカップコーヒクラス
class CupCoffee < Item
  def initialize(type)
    super("#{type} cup coffee", 100)
  end
end

#アイテムクラスを継承したスナッククラス
class Snack < Item
  def initialize
    super("potato chips", 150)
  end
end

#サンプルコード
hot_cup_coffee = CupCoffee.new('hot');
cider = Beverage.new('cider')
snack = Snack.new
vending_machine = VendingMachine.new('サントリー')
vending_machine.deposit_coin(100)
vending_machine.deposit_coin(100)
puts vending_machine.press_button(cider)

puts vending_machine.press_button(hot_cup_coffee)
vending_machine.add_cup(1)
puts vending_machine.press_button(hot_cup_coffee)

puts vending_machine.press_button(snack)
vending_machine.deposit_coin(100)
vending_machine.deposit_coin(100)
puts vending_machine.press_button(snack)