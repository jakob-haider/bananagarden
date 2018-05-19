class MoveTimeInformationOutOfBanana < ActiveRecord::Migration[5.1]
  def change
    remove_column :bananas, :nexttime
    remove_column :bananas, :slottime
  end
end
