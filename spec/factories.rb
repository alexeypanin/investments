FactoryGirl.define do
  factory :company do
    name { Faker::Company.name }
  end

  factory :credit do
    association :company, factory: :company

    started_at Date.today
    sum  1_000_000
    term_in_months 1
    period_in_months 6
    annual_rate_in_percents 30
    annual_delay_fine_in_percents 50
    finished_at nil
    payed_credit nil
    payed_percents nil
    annual_income_in_percents nil
  end

  factory :payment do
    association :credit, factory: :credit

    payed_credit 0
    payed_percents 0
    date Date.today
    payed_at Date.today
    delayed false
  end
end