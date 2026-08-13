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

ActiveRecord::Schema[7.1].define(version: 2026_08_13_121500) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "admin_custodian_id"
    t.string "admin_custodian_fname"
    t.index ["admin_custodian_id"], name: "index_accounts_on_admin_custodian_id"
  end

  create_table "children", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id", "name"], name: "index_children_on_account_id_and_name", unique: true
    t.index ["account_id"], name: "index_children_on_account_id"
  end

  create_table "custodians", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "fname", null: false
    t.string "lname"
    t.string "relationship_to_children"
    t.boolean "is_admin"
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_custodians_on_account_id"
  end

  create_table "nemo_children", force: :cascade do |t|
    t.integer "child_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "nemo_words", force: :cascade do |t|
    t.bigint "nemo_child_id", null: false
    t.string "word", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "sign", default: false
    t.date "date"
    t.index ["nemo_child_id", "word"], name: "index_nemo_words_on_nemo_child_id_and_word", unique: true
    t.index ["nemo_child_id"], name: "index_nemo_words_on_nemo_child_id"
  end

  create_table "words", force: :cascade do |t|
    t.bigint "child_id", null: false
    t.string "word", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date", default: "2026-06-22", null: false
    t.boolean "sign", default: false
    t.string "encoded_attr", default: "", null: false
    t.index ["child_id", "encoded_attr"], name: "index_words_on_child_id_and_encoded_attr", unique: true
    t.index ["child_id"], name: "index_words_on_child_id"
  end

  add_foreign_key "accounts", "custodians", column: "admin_custodian_id", on_delete: :nullify
  add_foreign_key "children", "accounts"
  add_foreign_key "custodians", "accounts"
  add_foreign_key "nemo_words", "nemo_children"
  add_foreign_key "words", "children"
end
