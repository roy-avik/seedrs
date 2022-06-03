class CreateInvestments < ActiveRecord::Migration[6.1]
  def change
    create_table :investments do |t|
      # t.bigint :campaign_id, null: false
      t.references :campaign, type: :bigint
      t.float :amount, null: false
      t.string :currency, null: false, index: true, default: 'GBP'
      t.string :email
      t.timestamps
    end
  end
end
