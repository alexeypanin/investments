class Credit < ActiveRecord::Base
  belongs_to :company

  validates :company, presence: true

  with_options numericality: { greater_than: 0 } do |credit|
    credit.validates :sum
    credit.validates :term_in_months
    credit.validates :period_in_months
    credit.validates :annual_rate_in_percents
    credit.validates :annual_delay_fine_in_percents
  end
end
