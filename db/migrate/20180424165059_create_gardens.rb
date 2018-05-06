class CreateGardens < ActiveRecord::Migration[5.1]
  def change
    create_table :gardens do |t|
      t.integer :sizex
      t.integer :sizey
      t.references :scheduler

      t.timestamps
    end
  end
end
