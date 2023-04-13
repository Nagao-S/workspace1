# frozen_string_literal: true

# 自動販売機クラス
class VendingMachine
  # 初期化
  def initialize
    # 自動販売機に入っている金額
    @deposit = 0
  end

  # お金を入れた時の処理
  def coin_put(coin)
    if [1, 5].include?(coin)
      puts "#{coin}円玉はつかえません"
    else
      @deposit += coin
    end
  end

  # ボタンを押した時の処理
  def push_button(item)
    if item.price <= @deposit && item.stock != 0
      @deposit -= item.price
      item.reduce_stock
      puts "#{item.name}が出る"
    elsif item.stock.zero?
      puts '売り切れました'
    else
      puts '金額が足りません'
    end
  end
end

# アイテムクラス
class Item
  attr_reader :name, :price, :stock

  # 初期化
  def initialize(name, price, stock)
    @name = name
    @price = price
    @stock = stock
  end

  def add_stock(amount)
    @stock += amount
    @stock = 100 if @stock > 100
  end

  def reduce_stock
    @stock -= 1
  end
end

# アイテムクラスを継承した飲料クラス
class Beverage < Item
  BEVERAGE_PRICES = { 'cider' => 100, 'cola' => 150, 'tea' => 120 }.freeze

  def initialize(name, stock)
    raise "None #{name}" unless BEVERAGE_PRICES.key?(name)

    super(name, BEVERAGE_PRICES[name], stock)
  end
end

# アイテムクラスを継承した菓子クラス
class Snack < Item
  SNACK_PRICES = { 'potat chip' => 100, 'choco' => 170, 'energy bar' => 200 }.freeze

  def initialize(name, stock)
    raise "None #{name}" unless SNACK_PRICES.key?(name)

    super(name, SNACK_PRICES[name], stock)
  end
end

# サンプル
vm = VendingMachine.new
cider = Beverage.new('cider', 10)
choco = Snack.new('choco', 5)

vm.coin_put(500)
vm.push_button(cider)
vm.push_button(choco)
