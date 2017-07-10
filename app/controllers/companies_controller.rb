class CompaniesController < ApplicationController
  before_filter :load_companies

  def index
    @company = Company.new
  end

  def create
    @company = Company.new(params[:company])
    if @company.save
      flash[:success] = 'Компания успешно добавлена'
      redirect_to companies_path
    else
      flash[:alert] = @company.errors.full_messages.to_sentence
      render :index
    end
  end

  def destroy
    @company = Company.find params[:id]

    if @company.credits.blank?
      @company.destroy
      flash[:success] = "Компания #{@company.name} успешно удалена"
    end

    redirect_to companies_path
  end

  protected

  def load_companies
    @companies =  Company.order('created_at desc')
  end
end
