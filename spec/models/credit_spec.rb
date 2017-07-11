require "rails_helper"

RSpec.describe Credit, :type => :model do
  it { should have_many(:payments) }
  it { should belong_to(:company) }

  it { should validate_presence_of(:company) }
  it { should validate_presence_of(:started_at) }
  it { should validate_numericality_of(:sum) }
  it { should validate_numericality_of(:term_in_months) }
  it { should validate_numericality_of(:period_in_months) }
  it { should validate_numericality_of(:annual_rate_in_percents) }
  it { should validate_numericality_of(:annual_delay_fine_in_percents) }

  context "sum calculations" do
    let (:credit) { create(:credit) }

    it "should calculate period payment sum" do
      credit.period_payment_сredit_sum.should == credit.sum / credit.term_in_months
    end

    it "should know next payment date" do
      expect(credit.next_payment_date).to be
    end

    it "should know sum for closing credit " do
      credit.closing_payment_сredit_sum.should == credit.sum - credit.period_payment_сredit_sum * credit.payments.count
    end

    it "should update cache fields after new payments was made" do
      expect(credit.payed_credit).to be_nil
      expect(credit.payed_percents).to be_nil
      expect(credit.annual_income_in_percents).to be_nil

      payment = build(:payment)
      payment.credit = credit
      payment.save

      expect(payment.payed_credit).to be
      expect(payment.payed_percents).to be

      expect(credit.payed_credit).to eql(payment.payed_credit)
      expect(credit.payed_percents).to eql(payment.payed_percents)
      expect(credit.annual_income_in_percents).to be

      payment2 = build(:payment)
      payment2.credit = credit
      payment2.save

      expect(credit.payed_credit).to eql(payment.payed_credit + payment2.payed_credit)
      expect(credit.payed_percents).to eql(payment.payed_percents + payment2.payed_percents)
    end

    it "should provide cached data for invest calculationson frontend" do
      expect(Credit.finished_credits_data).to eql({})

      company = create(:company)
      credit = create(:credit, company: company)
      payment = build(:payment, credit: credit)
      payment.closing_payment = '1'
      payment.save

      data = { company.id => [{
         :payed_credit   => credit.payed_credit,
         :payed_percents => credit.payed_percents,
         :annual_income_in_percents => credit.annual_income_in_percents}]
      }

      expect(Credit.finished_credits_data).to eql data
    end
  end
end
