class CreateBananas < ActiveRecord::Migration[5.1]
  def change
    create_table :bananas do |t|
      t.integer :numid
      t.string :color
      t.string :ripeState
      t.integer :ripeness
      t.string :specialtype
      t.string :slottime
      t.boolean :ismaxripe
      t.datetime :nexttime
      t.references :garden
      t.integer :posx
      t.integer :posy

      t.timestamps
    end
  end
end
