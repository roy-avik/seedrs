require 'rails_helper'

RSpec.describe CampaignsController, type: :request do

  let(:campaign_1) { FactoryBot.create(:campaign, investment_multiple: 4.97, target_amount: 999.97) }
  let(:campaign_2) { FactoryBot.create(:campaign, investment_multiple: 4.97, target_amount: 9999997) }
  let(:campaign_3) { FactoryBot.create(:campaign, investment_multiple: 4.97, target_amount: 6666666) }

  describe 'GET campaigns/' do
    context 'with filter params' do
      let(:campaigns_response) do
        CampaignSerializer.new(Campaign.where('target_amount > ?', 1000)).to_json
      end

      it 'responds with filtered results' do
        get "/campaigns?field_name=target_amount&operation=>&value=1000"
        expect(response.status).to eq(200)
        expect(response.body).to eq(campaigns_response)
      end

      context 'when field_name is invalid' do
        it 'responds with exception' do
          get "/campaigns?field_name=target_number&operation=>&value=1000"
          expect(response.status).to eq(422)
          expect(JSON.parse(response.body)['error']).to eq('Invalid Field Name!')
        end
      end

      context 'when operation is invalid' do

        let(:error_message) do
          "Invalid Operation! Valid OPERATIONS-> > < >= <= = != <> ilike iLIKE"
        end

        it 'responds with exception' do
          get "/campaigns?field_name=target_amount&operation=><&value=1000"
          expect(response.status).to eq(422)
          expect(JSON.parse(response.body)['error']).to eq(error_message)
        end
      end

      context 'when the operation is invalid for the field type' do
        it 'responds with exception' do
          get "/campaigns?field_name=sector&operation=>&value=1000"
          expect(response.status).to eq(422)
          expect(JSON.parse(response.body)['error']).to eq('Operation not possible for field type')
        end
      end
    end

    context 'without filter params' do

      it 'responds with all the campaign objects' do
        get '/campaigns'
        expect(response.status).to eq(200)
        expect(response.body).to eq(CampaignSerializer.new(Campaign.order(:id)).serializable_hash.to_json)
      end
    end
  end

  describe 'GET campaigns/:id' do
    context 'with valid :id' do

      it 'responds with the correct campaign object' do
        get "/campaigns/#{campaign_1.id}"
        expect(response.status).to eq(200)
        expect(response.body).to eq(CampaignSerializer.new(campaign_1).serializable_hash.to_json)
      end
    end

    context 'with invalid :id' do
      it 'throws exception' do
        get '/campaigns/0'
        expect(response.status).to eq(404)
        expect(JSON.parse(response.body)['error']).to eq('Couldn\'t find Campaign with \'id\'=0')
      end
    end
  end
end
