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

ActiveRecord::Schema.define(version: 0) do

  create_table "Category", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "categoryName", limit: 64
    t.datetime "createdTime"
    t.datetime "updatedTime"
  end

  create_table "Event", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "eventName"
    t.datetime "startDateTime"
    t.datetime "endDateTime"
    t.integer "maxParticipants"
    t.integer "minParticipants"
    t.string "organizerName"
    t.text "description", limit: 16777215
    t.string "eventStatus", limit: 6
    t.datetime "createdDateTime"
    t.datetime "updatedDateTime"
  end

  create_table "EventCategory", primary_key: ["categoryId", "eventId"], options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "categoryId", null: false
    t.integer "eventId", null: false
    t.index ["eventId"], name: "eventId"
  end

  create_table "EventRegistration", primary_key: ["userId", "eventId"], options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "eventId", null: false
    t.integer "userId", null: false
    t.boolean "attended"
    t.datetime "createdTime"
    t.datetime "updatedTime"
    t.boolean "withdrawed"
    t.index ["eventId"], name: "eventId"
  end

  create_table "Feedback", primary_key: "feedbackId", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "eventId"
    t.integer "userId"
    t.text "feedback", limit: 16777215
  end

  create_table "Subscriptions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "eventId"
    t.integer "userId"
    t.string "accountType", limit: 10
    t.index ["eventId"], name: "eventId"
    t.index ["userId"], name: "userId"
  end

  create_table "User", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "username", limit: 50
    t.string "password"
    t.string "accountType", limit: 10
    t.string "emailAddress"
    t.string "firstName", limit: 50
    t.string "lastName", limit: 50
    t.string "gender", limit: 6
    t.date "dateOfBirth"
    t.string "clientSecret"
    t.boolean "twoFactorEnabled"
    t.boolean "verified"
    t.datetime "createdDateTime"
    t.datetime "updatedDateTime"
    t.string "status", limit: 10
    t.index ["emailAddress"], name: "emailAddress", unique: true
    t.index ["username"], name: "username", unique: true
  end

  add_foreign_key "EventCategory", "Category", column: "categoryId", name: "EventCategory_ibfk_1"
  add_foreign_key "EventCategory", "Event", column: "eventId", name: "EventCategory_ibfk_2"
  add_foreign_key "EventRegistration", "Event", column: "eventId", name: "EventRegistration_ibfk_1"
  add_foreign_key "EventRegistration", "User", column: "userId", name: "EventRegistration_ibfk_2"
  add_foreign_key "Subscriptions", "Event", column: "eventId", name: "Subscriptions_ibfk_1"
  add_foreign_key "Subscriptions", "User", column: "userId", name: "Subscriptions_ibfk_2"
end
