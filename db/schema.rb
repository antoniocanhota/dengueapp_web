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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121121005511) do

  create_table "denunciantes", :force => true do |t|
    t.string   "situacao",   :limit => 4
    t.integer  "usuario_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "denuncias", :force => true do |t|
    t.datetime "data_e_hora"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "situacao",          :limit => 4
    t.integer  "denunciante_id",                 :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "dispositivo_id",                 :null => false
    t.string   "foto_file_name"
    t.string   "foto_content_type"
    t.integer  "foto_file_size"
    t.datetime "foto_updated_at"
  end

  create_table "dispositivos", :force => true do |t|
    t.string   "numero_do_telefone"
    t.string   "identificador_do_hardware"
    t.string   "identificador_do_android"
    t.string   "codigo_de_verificacao"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "denunciante_id",            :null => false
  end

  create_table "operadores", :force => true do |t|
    t.string   "tipo",       :limit => 4
    t.string   "situacao",   :limit => 4
    t.integer  "usuario_id",              :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "usuarios", :force => true do |t|
    t.string   "nome"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "usuarios", ["email"], :name => "index_usuarios_on_email", :unique => true
  add_index "usuarios", ["reset_password_token"], :name => "index_usuarios_on_reset_password_token", :unique => true

end
