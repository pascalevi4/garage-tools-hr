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

ActiveRecord::Schema.define(version: 20150918165035) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "resume_skills", force: :cascade do |t|
    t.integer  "resume_id"
    t.integer  "skill_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "resume_skills", ["resume_id", "skill_id"], name: "index_resume_skills_on_resume_id_and_skill_id", using: :btree

  create_table "resumes", force: :cascade do |t|
    t.text     "fio"
    t.string   "contacts"
    t.integer  "state"
    t.decimal  "salary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "skills", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "skills", ["title"], name: "index_skills_on_title", using: :btree

  create_table "vacancies", force: :cascade do |t|
    t.string   "title"
    t.datetime "expires_at"
    t.decimal  "salary"
    t.text     "contacts"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vacancy_skills", force: :cascade do |t|
    t.integer  "vacancy_id"
    t.integer  "skill_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "vacancy_skills", ["vacancy_id", "skill_id"], name: "index_vacancy_skills_on_vacancy_id_and_skill_id", using: :btree

end
