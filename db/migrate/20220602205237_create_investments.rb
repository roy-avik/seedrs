class CreateInvestments < ActiveRecord::Migration[6.1]
  def change
    create_table :investments do |t|
      t.references :campaign, foreign_key: { to_table: :campaigns }
      t.float :amount, null: false, index: true
      t.string :email
      t.timestamps
    end
  end
end
