# frozen_string_literal: true
# Devise-based user model.
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  has_many :decks
end

# == Schema Information
#
# Table name: users
#
# *id*::                     <tt>integer, not null, primary key</tt>
# *email*::                  <tt>string, default(""), not null</tt>
# *encrypted_password*::     <tt>string, default(""), not null</tt>
# *reset_password_token*::   <tt>string</tt>
# *reset_password_sent_at*:: <tt>datetime</tt>
# *remember_created_at*::    <tt>datetime</tt>
# *sign_in_count*::          <tt>integer, default(0), not null</tt>
# *current_sign_in_at*::     <tt>datetime</tt>
# *last_sign_in_at*::        <tt>datetime</tt>
# *current_sign_in_ip*::     <tt>string</tt>
# *last_sign_in_ip*::        <tt>string</tt>
# *created_at*::             <tt>datetime</tt>
# *updated_at*::             <tt>datetime</tt>
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#--
# == Schema Information End
#++
