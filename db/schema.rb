# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_06_02_205237) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "campaigns", force: :cascade do |t|
    t.string "name", null: false
    t.float "percentage_raised", default: 0.0, null: false
    t.integer "target_amount", null: false
    t.string "country", null: false
    t.integer "investment_multiple", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["country"], name: "index_campaigns_on_country"
    t.index ["name"], name: "index_campaigns_on_name"
    t.index ["percentage_raised"], name: "index_campaigns_on_percentage_raised"
    t.index ["target_amount"], name: "index_campaigns_on_target_amount"
  end

  create_table "investments", force: :cascade do |t|
    t.bigint "campaign_id"
    t.float "amount", null: false
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["amount"], name: "index_investments_on_amount"
    t.index ["campaign_id"], name: "index_investments_on_campaign_id"
  end

end
