# frozen_string_literal: true
FactoryGirl.define do
  factory :user do
    email { 'test@test.com' }
    password { 'super_secret' }
    password_confirmation { 'super_secret' }
    id { 42 }
  end

  factory :deck do
    name { 'Test Deck' }
    user_id { 42 }
    legal_format { 'Modern' }
    deck_type { 'beatdown' }

    factory :invalid_deck do
      name nil
    end
  end
end

# == Schema Information
#
# Table name: decks
#
# *id*::           <tt>integer, not null, primary key</tt>
# *user_id*::      <tt>integer</tt>
# *name*::         <tt>string</tt>
# *legal_format*:: <tt>string</tt>
# *deck_type*::    <tt>string</tt>
# *color*::        <tt>string</tt>
# *created_at*::   <tt>datetime</tt>
# *updated_at*::   <tt>datetime</tt>
#--
# == Schema Information End
#++
