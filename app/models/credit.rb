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

  scope :finished, -> { where('finished_at is not null') }

  class << self
    # данные по кредитам для калькулятора
    def finished_credits_data 
      data = Credit.finished.pluck(:company_id, :payed_credit, :payed_percents, :annual_income_in_percents)
      credits = {}

      data.each { |d|
         credits[d[0]] ||= []
         credits[d[0]] += [{
           payed_credit: d[1],
           payed_percents: d[2],
           annual_income_in_percents: d[3]
      }]}

      credits
    end
  end

  # сумма ежемесячного платежа по общему долгу
  def period_payment_сredit_sum
    sum / term_in_months
  end

  # дата внесения следующего платежа
  def next_payment_date
    started_at + ((1 + payments.count) * period_in_months).months
  end

  # сумма для закрытия всего долга по кредиту
  def closing_payment_сredit_sum
    sum - period_payment_сredit_sum * payments.count
  end

  # кэширование данных по статусу выплат платежей
  def update_stats
    return if payments.blank?

    self.payed_credit = payments.sum(:payed_credit)
    self.payed_percents = payments.sum(:payed_percents)
    self.annual_income_in_percents = (payed_percents / payed_credit * 12 / term_in_months) * 100

    if finished_at.blank? && ( payed_credit >= sum )
      self.finished_at = payments.last.payed_at
    end

    save
  end

  # для фронтенда
  def set_defaults
    self.started_at = Date.today
    self.sum = 1_000_000
    self.period_in_months = 1
    self.term_in_months = 6
    self.annual_rate_in_percents = 30
    self.annual_delay_fine_in_percents = 50
  end
end
