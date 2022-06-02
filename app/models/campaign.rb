class Campaign < ApplicationRecord
  validates :name, :percentage_raised, :target_amount, :country, :investment_multiple, presence: true

  has_many :investments, class_name: 'Investment', inverse_of: :campaign, dependent: :destroy
end
