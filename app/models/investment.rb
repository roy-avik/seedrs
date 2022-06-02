class Investment < ApplicationRecord
  belongs_to :campaign, class_name: 'Campaign', inverse_of: :investments

  validates :amount, :campaign, presence: true
  validate :amount_multiple_check

  private

  def amount_multiple_check
    investment_multiple = campaign.&investment_multiple
    return if (investment_multiple.present? && amount % investment_multiple == 0)

    errors.add(:amount, "is not a correct multiple of Investment Multiple!")
  end
end
