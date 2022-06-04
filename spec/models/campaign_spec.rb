require 'rails_helper'

RSpec.describe Campaign do
  let!(:campaign) { FactoryBot.create(:campaign) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:percentage_raised) }
    it { is_expected.to validate_presence_of(:target_amount) }
    it { is_expected.to validate_presence_of(:country) }
    it { is_expected.to validate_presence_of(:investment_multiple) }
  end
end