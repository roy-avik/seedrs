class InvestmentsController < ApplicationController

  # POST /investments
  def create
    @investment = Investment.new(investment_params)

    if @investment.save
      render :show, status: :created, location: @investment
    else
      format.json { render json: @investment.errors, status: :unprocessable_entity }
    end
  end

  private

    # Only allow a list of trusted parameters through.
    def investment_params
      params.require(:investment, :amount, :email, :campaign_id)
    end
end
