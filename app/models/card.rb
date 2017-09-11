# frozen_string_literal: true

# A model representation of a Magic card.
class Card < ApplicationRecord
  validates :name, presence: true
  validates :multiverse_id, presence: true, uniqueness: true

  has_many :deck_card
  has_many :decks, through: :deck_card
  belongs_to :magic_set

  # rubocop:disable MethodLength, AbcSize
  def self.from_api(json_card, magic_set)
    new(
      name: json_card['name'],
      multiverse_id: json_card['multiverseid'],
      magic_set_id: magic_set.id,
      image_url: json_card['imageUrl'],
      types: json_card['types'],
      subtypes: json_card['subtypes'],
      layout: json_card['layout'],
      cmc: json_card['cmc'],
      rarity: json_card['rarity'],
      text: json_card['text'],
      flavor: json_card['flavor'],
      artist: json_card['artist'],
      number: json_card['number'],
      power: json_card['power'],
      toughness: json_card['toughness'],
      loyalty: json_card['loyalty'],
      watermark: json_card['watermark'],
      border: json_card['border'] || magic_set.border,
      timeshifted: json_card['timeshifted'],
      hand: json_card['hand'],
      life: json_card['life'],
      reserved: json_card.fetch('reserved', false),
      release_date: json_card['release_date'],
      starter: json_card.fetch('starter', false),
      original_text: json_card['originalText'],
      original_type: json_card['originalType'],
      source: json_card['source']
    )
  end
  # rubocop:enable MethodLength, AbcSize
end

# == Schema Information
#
# Table name: cards
#
# *id*::            <tt>integer, not null, primary key</tt>
# *multiverse_id*:: <tt>string, not null</tt>
# *name*::          <tt>string, not null</tt>
# *image_url*::     <tt>string</tt>
# *types*::         <tt>string</tt>
# *subtypes*::      <tt>string</tt>
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
