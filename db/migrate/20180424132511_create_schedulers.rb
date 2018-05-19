class CreateSchedulers < ActiveRecord::Migration[5.1]
  def change
    create_table :schedulers do |t|
      t.references :garden
      t.timestamps
    end
  end
end
