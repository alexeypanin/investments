class Credit < ActiveRecord::Base
  belongs_to :company
  has_many :payments

  validates :company, presence: true
  validates :started_at, presence: true

  with_options numericality: { greater_than: 0 } do |credit|
    credit.validates :sum
    credit.validates :term_in_months
    credit.validates :period_in_months
    credit.validates :annual_rate_in_percents
    credit.validates :annual_delay_fine_in_percents
  end

  # сумма ежемесячного платежа по общему долгу
  def period_payment_сredit_sum
    sum / term_in_months
  end

  # дата внесения следующего платежа
  def next_payment_date
    started_at + (payments.count * period_in_months).months
  end

  # сумма для закрытия всего долга по кредиту
  def closing_payment_сredit_sum
    sum - period_payment_сredit_sum * payments.count
  end

  def update_stats
    return if payments.blank?

    self.payed_credit = payments.sum(:payed_credit)
    self.payed_percents = payments.sum(:payed_percents)
    self.annual_income_in_percents = (payed_percents / payed_credit * 12 / term_in_months) * 100

    if finished_at.blank? && ( payments.count == term_in_months / period_in_months )
      self.finished_at = Date.today
    end

    save
  end
end
