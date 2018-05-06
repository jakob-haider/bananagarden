class CreateFields < ActiveRecord::Migration[5.1]
  def change
    create_table :fields do |t|
      t.references :garden, foreign_key: true

      t.timestamps
    end
  end
end
