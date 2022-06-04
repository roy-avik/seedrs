puts "#{(1..25).map do |n|
	target_amount = Random.random_number(1000..10000000)
  c = Campaign.create!(
		name: "Campaign #{n}",
		percentage_raised: 0,
		target_amount: target_amount,
		country: 'United Kingdom',
		investment_multiple: target_amount/10,
		sector: %w(fintech biotech ai nanotech).sample
  )
  file = File.open(Rails.root.join('spec', 'fixtures', 'image.jpg'))

  c.image.attach(
    io: file,
    filename: File.basename(file),
  )

  c.save!
end.size} Campaigns has been created!"