# frozen_string_literal: true

FactoryGirl.define do
  factory :card do
    name { 'Test Card' }
    multiverse_id { 42 }

    factory :invalid_card do
      name nil
    end
  end
end

# == Schema Information
#
# Table name: cards
#
# *id*::            <tt>integer, not null, primary key</tt>
# *multiverse_id*:: <tt>string, not null</tt>
# *name*::          <tt>string, not null</tt>
# *image_url*::     <tt>string</tt>
# *card_type*::     <tt>string</tt>
# *subtype*::       <tt>string</tt>
# *layout*::        <tt>string</tt>
# *cmc*::           <tt>integer</tt>
# *rarity*::        <tt>string</tt>
# *text*::          <tt>text</tt>
# *flavor*::        <tt>string</tt>
# *artist*::        <tt>string</tt>
# *number*::        <tt>string</tt>
# *power*::         <tt>string</tt>
# *toughness*::     <tt>string</tt>
# *loyalty*::       <tt>integer</tt>
# *watermark*::     <tt>string</tt>
# *border*::        <tt>string</tt>
# *timeshifted*::   <tt>boolean</tt>
# *hand*::          <tt>string</tt>
# *life*::          <tt>string</tt>
# *reserved*::      <tt>boolean</tt>
# *release_date*::  <tt>string</tt>
# *starter*::       <tt>boolean</tt>
# *original_text*:: <tt>text</tt>
# *original_type*:: <tt>string</tt>
# *source*::        <tt>string</tt>
# *magic_set_id*::  <tt>integer</tt>
#
# Indexes
#
#  index_cards_on_multiverse_id  (multiverse_id) UNIQUE
#--
# == Schema Information End
#++
