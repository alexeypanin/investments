class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :credit_id
      t.float :payed_credit, default: 0
      t.float :payed_percents, default: 0
      t.date :date
      t.date :payed_at
      t.boolean :delayed, default: false

      t.timestamps
    end

    add_index :payments, :delayed
  end
end
