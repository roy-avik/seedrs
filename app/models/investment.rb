class Investment < ApplicationRecord

  belongs_to :campaign, class_name: 'Campaign', inverse_of: :investments

  validates :amount, :campaign, presence: true
  validate :verify_amount_validity, if: :amount
  validate :verify_currency, if: :currency
  validate :assign_currency, unless: :currency, if: :campaign
  validate :validate_email_format, if: :email

  delegate :currency, to: :campaign, prefix: true

  after_create :update_campaign_percentage_raised

  private

  def verify_amount_validity
    return if is_a_multiple?

    errors.add(:amount, "is not a correct multiple of Investment Multiple!")
  end

  def is_a_multiple?
    investment_multiple = campaign&.investment_multiple
    return false unless investment_multiple.present? && amount >= investment_multiple

    multiple = (amount * 1000000000).to_i % (investment_multiple * 1000000000).to_i
    multiple.zero?
   end

  def update_campaign_percentage_raised
    campaign.update_percentage_raised
  end

  def verify_currency
    return if campaign.present? && currency.downcase == campaign_currency&.downcase

    errors.add(:currency, "does not match with Campaign's currency!")
  end

  def assign_currency
    currency = campaign_currency
  end

  def validate_email_format
    return unless email.present?
    return if email.match?(URI::MailTo::EMAIL_REGEXP)

    errors.add(:email, 'is not a valid email')
  end
end
