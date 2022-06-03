class InvestmentsController < ApplicationController

  # POST /investments
  def create
    @investment = Investment.new(investment_params)
    @investment.save!

    render json: @investment, status: :created
  rescue StandardError => error
    puts error
    render json: error, status: :unprocessable_entity
  end

  private

    # Only allow a list of trusted parameters through.
    def investment_params
      params.require(:investment).permit(:amount, :email, :campaign_id)
    end
end
