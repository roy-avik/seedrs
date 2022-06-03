require 'rails_helper'

RSpec.describe Investment do
  let!(:campaign) { FactoryBot.create(:campaign) }
  let(:investment) { FactoryBot.create(:investment, campaign: campaign) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:amount) }
    it { is_expected.to validate_presence_of(:campaign) }
  end
end