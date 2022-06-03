class Campaign < ApplicationRecord
  
  has_many :investments, class_name: 'Investment', inverse_of: :campaign, dependent: :destroy
  validates :name, :percentage_raised, :target_amount, :country, :investment_multiple, :sector, presence: true
  validate :investment_multiple_integrity

  private

  def investment_multiple_integrity

  end
end
