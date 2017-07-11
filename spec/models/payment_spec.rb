require "rails_helper"

RSpec.describe Payment, :type => :model do
  context "calculations" do
    before (:each) do
      @credit = create(:credit)
    end

    it "should set payed credit part before save" do
      payment = build(:payment)
      payment.credit = @credit

      expect(payment.payed_credit).to eq(0)

      payment.save

      expect(payment.payed_credit).to eq(@credit.period_payment_сredit_sum)
    end

    it "should set payed credit part for closing credit write know" do
      payment = build(:payment)
      payment.credit = @credit

      expect(payment.payed_credit).to eq(0)
      expect(@credit.finished_at).to be nil

      closing_sum = @credit.period_payment_сredit_sum

      payment.closing_payment = '1'
      payment.save

      expect(payment.payed_credit).to eq(closing_sum)
      expect(@credit.finished_at).to be
    end

    it "should set percents credit part before save" do
      payment = build(:payment)
      payment.credit = @credit

      expect(payment.payed_percents).to eq(0)

      payment.save

      expect(payment.payed_percents).to eq @credit.sum * @credit.annual_rate_in_percents / ( 12 * 100 )
    end

    it "should set percents with fine if payment was made after planned date" do
      payment = build(:payment)
      payment.credit = @credit
      payment.date = @credit.next_payment_date

      expect(payment.payed_percents).to eq(0)
      expect(payment.delayed).to be false

      payment.payed_at = payment.date + 2.days
      payment.save

      expect(payment.payed_percents).to eq (@credit.sum * @credit.annual_delay_fine_in_percents / ( 12 * 100 )).round(2)
      expect(payment.delayed).to be true
    end

    it "should update cache in credit after save" do
      payment = build(:payment)
      payment.credit = @credit
      payment.date = @credit.next_payment_date

      expect(@credit.payed_credit).to be_nil
      expect(@credit.payed_percents).to be_nil
      expect(@credit.annual_income_in_percents).to be_nil

      payment.save

      expect(@credit.payed_credit).to be
      expect(@credit.payed_percents).to be
      expect(@credit.annual_income_in_percents).to be
    end
  end
end
