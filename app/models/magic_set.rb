# frozen_string_literal: true

# A Magic Set.
class MagicSet < ApplicationRecord
  has_many :cards
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
