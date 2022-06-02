puts "#{(1..25).map do |n|
	target_amount = Random.random_number(1000..10000000)
  Campaign.create(
		name: "Campaign #{n}",
		percentage_raised: 0,
		target_amount: target_amount,
		country: FFaker::Address.country,
		investment_multiple: target_amount/Random.random_number(99).round,
  )
end.size} Campaigns has been created!"