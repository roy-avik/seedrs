class CampaignsController < ApplicationController
  ALLOWED_ATTRS = Campaign.columns.map { |c| [c.name, c.type] }
  ALLOWED_OPS = %w(> < >= <= = != <> ilike iLIKE)

  def index
    @campaigns = Campaign.where(Campaign.sanitize_sql(filter_query), sanitized_value) if params[:field_name].present?
    @campaigns ||= Campaign.order(:id)

    render json: { campaigns: CampaignSerializer.new(@campaigns).serializable_hash }

  rescue StandardError => error
    puts error
    render json: { error: error }, status: :unprocessable_entity
  end

  def show
    @campaign = Campaign.find(params[:id])

    render json: CampaignSerializer.new(@campaign).serializable_hash
  end

  private

  def filter_query
    "#{allowed_field_names} #{allowed_operations} ?"
  end

  def allowed_field_names
    field_name = params.dig(:field_name)
    return unless field_name

    raise StandardError, 'Invalid Field Name! ' unless ALLOWED_ATTRS.map(&:first).include?(field_name)

    field_name
  end

  def allowed_operations
    operation = params.dig(:operation)
    return unless operation

    raise StandardError, "Invalid Operation! Valid OPERATIONS-> #{ALLOWED_OPS.join(' ')}" unless ALLOWED_OPS.include?(operation)
    raise StandardError, 'Operation not possible for field type' if invalid_operation_for_type?(operation)

    operation.eql?('ilike') ? "iLIKE" : operation
  end

  def invalid_operation_for_type?(operation)
    case ALLOWED_ATTRS.to_h[params.dig(:field_name)]
    when :string
      %w(> < >= <=)
    when :integer
      %w(ilike iLIKE)
    when :float
      %w(ilike iLIKE)
    when :datetime
      %w(ilike iLIKE)
    end.include?(operation)
  end

  def sanitized_value
    value = params.dig(:value)&.gsub(/[^[:alnum:]]+/, '_')
    return "%#{value}%" if %w(ilike iLIKE).include?(params.dig(:operation))

    value
  end
end
