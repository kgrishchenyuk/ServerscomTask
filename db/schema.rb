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

ActiveRecord::Schema.define(version: 2021_08_02_114814) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "hosts", force: :cascade do |t|
    t.inet "ipaddr", null: false
    t.boolean "active", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ipaddr"], name: "index_hosts_on_ipaddr", unique: true
  end

  create_table "ping_results", force: :cascade do |t|
    t.boolean "success", null: false
    t.integer "transmitted", null: false
    t.integer "received", null: false
    t.float "min_rtt"
    t.float "avg_rtt"
    t.float "max_rtt"
    t.float "mdev_rtt"
    t.bigint "host_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["host_id", "created_at"], name: "index_ping_results_on_host_id_and_created_at", unique: true
  end

  add_foreign_key "ping_results", "hosts"
end
