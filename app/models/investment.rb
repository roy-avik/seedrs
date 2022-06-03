class Investment < ApplicationRecord
  belongs_to :campaign, class_name: 'Campaign', inverse_of: :investments

  validates :amount, :campaign, presence: true
  validate :amount_multiple_check, if: :amount

  after_create :update_campaign

  private

  def amount_multiple_check
    return if is_a_multiple?

    errors.add(:amount, "is not a correct multiple of Investment Multiple!")
  end

  def is_a_multiple?
    investment_multiple = campaign&.investment_multiple
    return false unless investment_multiple && amount >= investment_multiple

    amount_in_cents = (amount * 100).to_i
    investment_multiple_in_cents = (investment_multiple * 100).to_i

    puts multiple = amount_in_cents / investment_multiple_in_cents 

    multiple - multiple.ceil <= Float::EPSILON
    # (amount - expected_multiple_amount).abs <= Float::EPSILON
    # bind special case
    # (fraction - fraction.floor.to_f).abs <= Float::EPSILON
    # Float::EPSILON % (multiple - multiple.floor.to_f) == 0
    # amount * 100.0 == (multiple.to_i * investment_multipl.0)
  end

  def update_campaign
    campaign.update!(
      percentage_raised: campaign.investments.pluck(:amount).sum / campaign.target_amount * 100.0,
    )
  end
end
