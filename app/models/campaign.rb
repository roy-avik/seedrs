class Campaign < ApplicationRecord
  has_one_attached :image
  has_many :investments, class_name: 'Investment', inverse_of: :campaign, dependent: :destroy
  validates :name, :percentage_raised, :target_amount, :country, :investment_multiple, :sector, presence: true

  def update_percentage_raised
    update!(percentage_raised: investments.pluck(:amount).sum / target_amount * 100.0)
  end
end
