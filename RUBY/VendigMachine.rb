class VendingMachine
  #初期化
  def initialize(manufacturer_name)
    @manufacturer_name = manufacturer_name
    @deposit = 0
  end
  #コインが入れられたときの挙動
  def deposit_coin(coin)
    @deposit += 100 if coin == 100
  end
  #ボタンが押されたときの挙動
  def press_button(item)
    if @deposit >= item.price
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

class Item
  attr_reader :name, :price
  def initialize(name,price)
    @name = name
    @price = price
  end
end

cola = Item.new('cola',150)
cider = Item.new('cider',100)
vending_machine = VendingMachine.new('サントリー')

vending_machine.deposit_coin(100)
puts vending_machine.press_button(cola)
vending_machine.deposit_coin(100)
vending_machine.deposit_coin(100)
puts vending_machine.press_button(cola)
puts vending_machine.press_button(cider)