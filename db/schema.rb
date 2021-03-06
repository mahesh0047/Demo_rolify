# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_201_205_044_100) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'addresses', force: :cascade do |t|
    t.string 'name'
    t.bigint 'company_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.bigint 'state_id'
    t.bigint 'city_id'
    t.index ['city_id'], name: 'index_addresses_on_city_id'
    t.index ['company_id'], name: 'index_addresses_on_company_id'
    t.index ['state_id'], name: 'index_addresses_on_state_id'
  end

  create_table 'cities', force: :cascade do |t|
    t.string 'name'
    t.bigint 'state_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['state_id'], name: 'index_cities_on_state_id'
  end

  create_table 'companies', force: :cascade do |t|
    t.string 'name'
    t.string 'web_url'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'languages', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'languages_users', id: false, force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.bigint 'language_id', null: false
    t.index ['language_id'], name: 'index_languages_users_on_language_id'
    t.index ['user_id'], name: 'index_languages_users_on_user_id'
  end

  create_table 'projects', force: :cascade do |t|
    t.string 'name'
    t.date 'start_date'
    t.bigint 'language_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['language_id'], name: 'index_projects_on_language_id'
  end

  create_table 'roles', force: :cascade do |t|
    t.string 'name'
    t.string 'resource_type'
    t.bigint 'resource_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index %w[name resource_type resource_id], name: 'index_roles_on_name_and_resource_type_and_resource_id'
    t.index %w[resource_type resource_id], name: 'index_roles_on_resource_type_and_resource_id'
  end

  create_table 'sessions', force: :cascade do |t|
    t.string 'session_id', null: false
    t.text 'data'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['session_id'], name: 'index_sessions_on_session_id', unique: true
    t.index ['updated_at'], name: 'index_sessions_on_updated_at'
  end

  create_table 'states', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'name'
    t.string 'phone_no'
    t.bigint 'state_id'
    t.bigint 'city_id'
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.bigint 'company_id'
    t.string 'provider', limit: 50, default: '', null: false
    t.string 'uid', limit: 500, default: '', null: false
    t.index ['city_id'], name: 'index_users_on_city_id'
    t.index ['company_id'], name: 'index_users_on_company_id'
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
    t.index ['state_id'], name: 'index_users_on_state_id'
  end

  create_table 'users_roles', id: false, force: :cascade do |t|
    t.bigint 'user_id'
    t.bigint 'role_id'
    t.index ['role_id'], name: 'index_users_roles_on_role_id'
    t.index %w[user_id role_id], name: 'index_users_roles_on_user_id_and_role_id'
    t.index ['user_id'], name: 'index_users_roles_on_user_id'
  end

  add_foreign_key 'addresses', 'cities'
  add_foreign_key 'addresses', 'companies'
  add_foreign_key 'addresses', 'states'
  add_foreign_key 'cities', 'states'
  add_foreign_key 'projects', 'languages'
  add_foreign_key 'users', 'cities'
  add_foreign_key 'users', 'companies'
  add_foreign_key 'users', 'states'
end
