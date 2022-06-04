class InvestmentsController < ApplicationController

  def new
    @campaign = Campaign.find(params[:campaign_id])
    @investment = Investment.new
  end

  # POST /investments
  def create
    @investment = Investment.new(investment_params.merge(campaign_id: params[:campaign_id]))
    @investment.save!

    render json: @investment, status: :created
  rescue StandardError => error
    puts error
    render json: error, status: :unprocessable_entity
  end

  private

    # Only allow a list of trusted parameters through.
    def investment_params
      params.require(:investment).permit(:amount, :email)
    end
end
