class Investment < ApplicationRecord
  belongs_to :campaign, class_name: 'Campaign', inverse_of: :investments, foreign_key: 'campaign_id'

  validates :amount, presence: true
  validate :amount_multiple_check

  private

  def amount_multiple_check
    investment_multiple = campaign.investment_multiple

    return false unless (amount % investment_multiple == 0)
  end
end
