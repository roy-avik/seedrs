require 'rails_helper'

RSpec.describe InvestmentsController, type: :request do

  let(:campaign) { FactoryBot.create(:campaign, investment_multiple: 4.97, target_amount: 999.97) }

  describe 'POST campaigns/:campaign_id/investments' do

    context 'with valid params' do

      let(:params) do
        {
          investment: {
            # amount: 49.7,
            amount: 9.9399991,
            campaign_id: campaign.id,
          }
        }
      end

      let(:percentage_raised) { params[:investment][:amount] / campaign.target_amount * 100.0 }

      it 'creates an investment' do
        expect { post "/campaigns/#{campaign.id}/investments", params: params }.to change(Investment, :count).by(1)
        expect(response.body).to eq(Investment.last.to_json)
        expect(response.status).to eq(201)
      end

      it 'updates the campaign' do
        expect(campaign.percentage_raised).to eq(0.0)
        post "/campaigns/#{campaign.id}/investments", params: params
        expect(campaign.reload.percentage_raised).to eq(percentage_raised)
      end
    end

    context 'with invalid params' do

      it 'throws exception' do
        post "/campaigns/#{campaign.id}/investments", params: { investment: { campaign_id: campaign.id } }
        expect(response.status).to eq(422)
      end
    end

    context 'with invalid campaign' do

      let(:error_message) do
        "Validation failed: Campaign must exist, Campaign can't be blank, Amount is not a correct multiple of Investment Multiple!"
      end

      it 'throws exception' do
        post "/campaigns/0/investments", params: { investment: { amount: 10 } }

        expect(JSON.parse(response.body)).to eq(error_message)
        expect(response.status).to eq(422)
      end
    end
  end
end
