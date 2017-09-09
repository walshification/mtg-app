# frozen_string_literal: true

# A Magic Set.
class MagicSet < ApplicationRecord
  has_many :cards

  def self.from_api(json_magic_set)
    find_or_create_by(
      block: json_magic_set['block'],
      border: json_magic_set['border'],
      code: json_magic_set['code'],
      gatherer_code: json_magic_set['gathererCode'] || json_magic_set['code'],
      magiccards_info_code: json_magic_set['magicCardsInfoCode'],
      name: json_magic_set['name'],
      online_only: json_magic_set['online_only'] == 'f',
      release_date: json_magic_set['releaseDate'],
      set_type: json_magic_set['type']
    )
  end
end

# == Schema Information
#
# Table name: magic_sets
#
# *id*::                   <tt>integer, not null, primary key</tt>
# *name*::                 <tt>string</tt>
# *code*::                 <tt>string</tt>
# *gatherer_code*::        <tt>string</tt>
# *magiccards_info_code*:: <tt>string</tt>
# *border*::               <tt>string</tt>
# *set_type*::             <tt>string</tt>
# *block*::                <tt>string</tt>
# *release_date*::         <tt>string</tt>
# *online_only*::          <tt>boolean, default(FALSE)</tt>
#--
# == Schema Information End
#++
