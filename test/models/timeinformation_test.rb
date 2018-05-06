# == Schema Information
#
# Table name: timeinformations
#
#  id                :integer          not null, primary key
#  creationtime      :time
#  nexttime          :time
#  processed_on_time :boolean
#  to_be_processed   :boolean
#  banana_id         :integer
#  scheduler_id      :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'test_helper'

class TimeinformationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
