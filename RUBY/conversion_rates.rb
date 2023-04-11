def convert_currency(amount,source_currency,target_currency,conversion_rates)
  #source_currencyに金額を変換する
  amount_converted = amount * conversion_rates[target_currency] / conversion_rates[source_currency]
end

conversion_rates = {
  usd: 1.0,
  jpy: 110.0,
  eur: 0.8
}

# サンプル呼び出し
result = convert_currency(100, :usd, :jpy, conversion_rates)

# 結果を出力
puts result