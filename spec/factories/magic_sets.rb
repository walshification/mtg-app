# frozen_string_literal: true

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :magic_set do
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
