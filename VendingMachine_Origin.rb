#自動販売機クラス
class VendingMachine
  #初期化
  def initialize

  end

  #お金を入れた時の処理

  #ボタンを押した時の処理

  #補充した際の処理
  
end

#アイテムクラス
class Item
  attr_reader :name,:price
  #初期化
  def initialize
    @name = name
    @price = price
  end
end

#アイテムクラスを継承した飲料クラス
class Beverage < Item

end

#アイテムクラスを継承した菓子クラス
class Snack < Item
  
end