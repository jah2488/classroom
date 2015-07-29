class CleanupDeviseMerge < ActiveRecord::Migration
  def change
    remove_column :students, :email
    remove_column :students, :name
    remove_column :students, :github
    remove_column :students, :encrypted_password
    remove_column :students, :reset_password_token
    remove_column :students, :reset_password_sent_at
    remove_column :students, :remember_created_at
    remove_column :students, :sign_in_count
    remove_column :students, :current_sign_in_at
    remove_column :students, :last_sign_in_at
    remove_column :students, :current_sign_in_ip
    remove_column :students, :last_sign_in_ip
    remove_column :instructors, :email
    remove_column :instructors, :name
    remove_column :instructors, :encrypted_password
    remove_column :instructors, :reset_password_token
    remove_column :instructors, :reset_password_sent_at
    remove_column :instructors, :remember_created_at
    remove_column :instructors, :sign_in_count
    remove_column :instructors, :current_sign_in_at
    remove_column :instructors, :last_sign_in_at
    remove_column :instructors, :current_sign_in_ip
    remove_column :instructors, :last_sign_in_ip
  end
end
