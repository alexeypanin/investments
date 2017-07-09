class Payment < ActiveRecord::Base
  attr_accessor :closing_payment # для передачи типа платежа из формы внесения платежа

  belongs_to :credit

  before_validation :set_payment_parts

  validates :payed_at, presence: true
  validates :date, presence: true, uniqueness: {scope: :credit_id, message: 'платеж за данный месяц уже внесен'}

  validate :check_dates

  default_scope  { order(:date => :asc) }

  after_save :update_credit_stats

  protected

  def set_payment_parts
    self.payed_credit = closing_payment ? credit.closing_payment_сredit_sum : credit.period_payment_сredit_sum
    self.payed_percents = calculate_payment_percents
  end

  # сумма платежа по процентам
  def calculate_payment_percents
    # если платеж внесен вовремя
    if payed_at == credit.next_payment_date
      credit.sum * credit.annual_rate_in_percents / ( 12 * 100 )
    # если платеж внесен с опозданием
    elsif payed_at > credit.next_payment_date
      self.delayed = true
      credit.sum * credit.annual_delay_fine_in_percents / ( 12 * 100 )
    end
  end

  # проверка даты платежа и даты внесения платежа
  def check_dates
    if date < credit.started_at
      self.errors.add(:date, 'не может быть раньше выдачи кредита')
    elsif date > credit.started_at + (credit.term_in_months * credit.period_in_months).months
      self.errors.add(:date, 'больше срока кредита')
    end

    if payed_at < date
      self.errors.add(:payed_at, 'не может быть раньше установленного срока')
    end
  end

  def update_credit_stats
    credit.update_stats
  end
end
