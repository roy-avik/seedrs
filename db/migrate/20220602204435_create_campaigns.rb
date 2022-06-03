class CreateCampaigns < ActiveRecord::Migration[6.1]
  def change
    create_table :campaigns do |t|
      t.string :name, null: false, index: true
      t.string :sector, null: false, index: true
      t.float :percentage_raised, index: true, default: 0, null: false
      t.integer :target_amount, null: false, index: true
      t.string :country, null: false, index: true
      t.float :investment_multiple, null: false
      t.string :currency, null: false, index: true, default: 'GBP'
      t.timestamps
    end
  end
end
