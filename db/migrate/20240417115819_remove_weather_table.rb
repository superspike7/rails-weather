class RemoveWeatherTable < ActiveRecord::Migration[7.1]
  def change
    drop_table :weathers

    add_column :locations, :weather_data, :jsonb, null: true
  end
end
