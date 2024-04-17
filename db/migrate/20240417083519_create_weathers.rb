class CreateWeathers < ActiveRecord::Migration[7.1]
  def change
    create_table :weathers do |t|
      t.date :date
      t.integer :code
      t.float :temperature
      t.float :wind_speed
      t.float :humidity
      t.references :location, null: false, foreign_key: true

      t.timestamps
    end
  end
end
