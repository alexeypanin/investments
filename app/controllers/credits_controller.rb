class CreditsController < ApplicationController
  before_filter :load_company
  before_filter :find_credit, only: [:show, :edit, :update, :destroy, :add_payment]

  def new
    @credit = @company.credits.build
    @credit.set_defaults
  end

  def show
    @payments = @credit.payments
    @payment = Payment.new
  end

  def create
    @credit = @company.credits.build(params[:credit])
    if @credit.save
      flash[:success] = 'Кредит успешно выдан'
      redirect_to company_credit_path(@company, @credit)
    else
      flash[:alert] = @credit.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    if @credit.update_attributes(params[:credit])
      flash[:success] = 'Кредит успешно обновлен'
      redirect_to company_credit_path(@company, @credit)
    else
      flash[:alert] = @credit.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    if @credit.payments.blank?
      @credit.destroy
      flash[:success] = "Кредит успешно удален"
    end

    redirect_to company_path(@company)
  end

  def add_payment
    @payment = @credit.payments.build params[:payment]
    if @payment.save
      flash[:success] = 'Платеж успешно внесен'
      redirect_to company_credit_path(@company, @credit)
    else
      @payments = @credit.payments
      flash[:alert] = @payment.errors.full_messages.to_sentence
      render :show
    end
  end

  protected

  def load_company
    @company = Company.find params[:company_id]
  end

  def find_credit
    @credit = @company.credits.find(params[:id])
    @credit = CreditDecorator.decorate(@credit)
  end
end
