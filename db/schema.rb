# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170708121948) do

  create_table "companies", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "companies", ["name"], name: "index_companies_on_name", unique: true

  create_table "credits", force: true do |t|
    t.integer  "company_id"
    t.float    "sum"
    t.integer  "term_in_months"
    t.integer  "period_in_months"
    t.float    "annual_rate_in_percents"
    t.float    "annual_delay_fine_in_percents"
    t.date     "started_at"
    t.date     "finished_at"
    t.float    "payed_credit"
    t.float    "payed_percents"
    t.float    "annual_income_in_percents"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", force: true do |t|
    t.integer  "credit_id"
    t.float    "sum"
    t.float    "payed_credit"
    t.float    "payed_percents"
    t.date     "payed_at"
    t.boolean  "delayed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
