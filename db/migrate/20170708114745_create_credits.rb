class CreateCredits < ActiveRecord::Migration
  def change
    create_table :credits do |t|
      t.integer :company_id
      t.float :sum
      t.integer :term_in_months
      t.integer :period_in_months
      t.float :annual_rate_in_percents
      t.float :annual_delay_fine_in_percents
      t.date :started_at
      t.date :finished_at
      t.float :payed_credit, default: 0
      t.float :payed_percents, default: 0
      t.float :annual_income_in_percents, default: 0

      t.timestamps
    end
  end
end
