class AddIndexToBloodGlucoseOnReadingDate < ActiveRecord::Migration[6.0]
  def change
    add_index :blood_glucoses, :reading_date
  end
end
