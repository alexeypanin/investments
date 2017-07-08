class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :credit_id
      t.float :sum
      t.float :payed_credit
      t.float :payed_percents
      t.date :payed_at
      t.boolean :delayed

      t.timestamps
    end
  end
end
