# == Schema Information
#
# Table name: magic_sets
#
#  id                   :integer          not null, primary key
#  name                 :string
#  code                 :string
#  gatherer_code        :string
#  magiccards_info_code :string
#  border               :string
#  set_type             :string
#  block                :string
#  release_date         :string
#  online_only          :boolean          default(FALSE)
#

class MagicSet < ApplicationRecord
end
