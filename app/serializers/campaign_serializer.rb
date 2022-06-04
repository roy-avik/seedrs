class CampaignSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :sector, :country, :investment_multiple, :percentage_raised, :target_amount

  attribute :investments_received do |object|
    object.investments.size
  end
end
