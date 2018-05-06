class CreateTimetickets < ActiveRecord::Migration[5.1]
  def change
    create_table :timetickets do |t|
      t.references :banana, foreign_key: true
      t.datetime :time

      t.timestamps
    end
  end
end
