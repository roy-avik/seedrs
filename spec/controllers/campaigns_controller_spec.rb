require 'rails_helper'

RSpec.describe CampaignsController, type: :request do

  let(:campaign_1) { FactoryBot.create(:campaign, investment_multiple: 4.97, target_amount: 999.97) }
  let(:campaign_2) { FactoryBot.create(:campaign, investment_multiple: 4.97, target_amount: 9999997) }
  let(:campaign_3) { FactoryBot.create(:campaign, investment_multiple: 4.97, target_amount: 6666666) }

  describe 'GET campaigns/' do
    context 'with filter params' do
      let(:campaigns_response) do
        CampaignSerializer.new(Campaign.where('target_name > ?', 1000)).serializable_hash
      end

      it 'responds with filtered results' do
        get "/campaigns?field_name=target_amount&operation=>&value=1000"
        expect(response.status).to eq(200)
        expect(response.body).to eq(campaigns_response)
      end

      context 'when field_name is invalid' do

      end

      context 'when operation is invalid' do

      end

      context 'when the operation is invalid for the field type' do

      end
    end

    context 'without filter params' do

      it 'responds with all the campaign objects' do
        get '/campaigns'
        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)).to eq(CampaignSerializer.new(Campaign.order(:id)).serializable_hash)
      end
    end
  end

  describe 'GET campaigns/:id' do
    context 'with valid :id' do

      it 'responds with the correct campaign object' do
        get "/campaigns/#{campaign_1.id}"
        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)).to eq(CampaignSerializer.new(campaign_1).serializable_hash)
      end
    end

    context 'with invalid :id' do
      get '/campaigns/0'
      expect(response.status).to eq(404)
      expect(response.body).to eq('')
    end
  end
end
