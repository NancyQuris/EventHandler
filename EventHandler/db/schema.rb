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

  create_table "auth_group", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name", limit: 150, null: false
    t.index ["name"], name: "name", unique: true
  end

  create_table "auth_group_permissions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "group_id", null: false
    t.integer "permission_id", null: false
    t.index ["group_id", "permission_id"], name: "auth_group_permissions_group_id_permission_id_0cd325b0_uniq", unique: true
    t.index ["permission_id"], name: "auth_group_permissio_permission_id_84c5c92e_fk_auth_perm"
  end

  create_table "auth_permission", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name", null: false
    t.integer "content_type_id", null: false
    t.string "codename", limit: 100, null: false
    t.index ["content_type_id", "codename"], name: "auth_permission_content_type_id_codename_01ab375a_uniq", unique: true
  end

  create_table "auth_user", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "password", limit: 128, null: false
    t.datetime "last_login", precision: 6
    t.boolean "is_superuser", null: false
    t.string "username", limit: 150, null: false
    t.string "first_name", limit: 30, null: false
    t.string "last_name", limit: 150, null: false
    t.string "email", limit: 254, null: false
    t.boolean "is_staff", null: false
    t.boolean "is_active", null: false
    t.datetime "date_joined", precision: 6, null: false
    t.index ["username"], name: "username", unique: true
  end

  create_table "auth_user_groups", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "group_id", null: false
    t.index ["group_id"], name: "auth_user_groups_group_id_97559544_fk_auth_group_id"
    t.index ["user_id", "group_id"], name: "auth_user_groups_user_id_group_id_94350c0c_uniq", unique: true
  end

  create_table "auth_user_user_permissions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "permission_id", null: false
    t.index ["permission_id"], name: "auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm"
    t.index ["user_id", "permission_id"], name: "auth_user_user_permissions_user_id_permission_id_14a6b632_uniq", unique: true
  end

  create_table "django_admin_log", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.datetime "action_time", precision: 6, null: false
    t.text "object_id", limit: 4294967295
    t.string "object_repr", limit: 200, null: false
    t.integer "action_flag", limit: 2, null: false, unsigned: true
    t.text "change_message", limit: 4294967295, null: false
    t.integer "content_type_id"
    t.integer "user_id", null: false
    t.index ["content_type_id"], name: "django_admin_log_content_type_id_c4bce8eb_fk_django_co"
    t.index ["user_id"], name: "django_admin_log_user_id_c564eba6_fk_auth_user_id"
  end

  create_table "django_content_type", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "app_label", limit: 100, null: false
    t.string "model", limit: 100, null: false
    t.index ["app_label", "model"], name: "django_content_type_app_label_model_76bd3d3b_uniq", unique: true
  end

  create_table "django_migrations", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "app", null: false
    t.string "name", null: false
    t.datetime "applied", precision: 6, null: false
  end

  create_table "django_session", primary_key: "session_key", id: :string, limit: 40, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.text "session_data", limit: 4294967295, null: false
    t.datetime "expire_date", precision: 6, null: false
    t.index ["expire_date"], name: "django_session_expire_date_a5c62663"
  end

  add_foreign_key "EventCategory", "Category", column: "categoryId", name: "EventCategory_ibfk_1"
  add_foreign_key "EventCategory", "Event", column: "eventId", name: "EventCategory_ibfk_2"
  add_foreign_key "EventRegistration", "Event", column: "eventId", name: "EventRegistration_ibfk_1"
  add_foreign_key "EventRegistration", "User", column: "userId", name: "EventRegistration_ibfk_2"
  add_foreign_key "Subscriptions", "Event", column: "eventId", name: "Subscriptions_ibfk_1"
  add_foreign_key "Subscriptions", "User", column: "userId", name: "Subscriptions_ibfk_2"
  add_foreign_key "auth_group_permissions", "auth_group", column: "group_id", name: "auth_group_permissions_group_id_b120cbf9_fk_auth_group_id"
  add_foreign_key "auth_group_permissions", "auth_permission", column: "permission_id", name: "auth_group_permissio_permission_id_84c5c92e_fk_auth_perm"
  add_foreign_key "auth_permission", "django_content_type", column: "content_type_id", name: "auth_permission_content_type_id_2f476e4b_fk_django_co"
  add_foreign_key "auth_user_groups", "auth_group", column: "group_id", name: "auth_user_groups_group_id_97559544_fk_auth_group_id"
  add_foreign_key "auth_user_groups", "auth_user", column: "user_id", name: "auth_user_groups_user_id_6a12ed8b_fk_auth_user_id"
  add_foreign_key "auth_user_user_permissions", "auth_permission", column: "permission_id", name: "auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm"
  add_foreign_key "auth_user_user_permissions", "auth_user", column: "user_id", name: "auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id"
  add_foreign_key "django_admin_log", "auth_user", column: "user_id", name: "django_admin_log_user_id_c564eba6_fk_auth_user_id"
  add_foreign_key "django_admin_log", "django_content_type", column: "content_type_id", name: "django_admin_log_content_type_id_c4bce8eb_fk_django_co"
end
