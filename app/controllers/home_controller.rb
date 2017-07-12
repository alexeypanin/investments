class HomeController < ApplicationController
  def index
    # gon.credits = Credit.finished_credits_data
    @credits = Credit.finished_credits_data
  end
end
