class CreateBloodGlucoses < ActiveRecord::Migration[6.0]
  def change
    create_table :blood_glucoses do |t|
      t.integer :value
      t.datetime :reading_date
      t.integer :user_id

      t.timestamps
    end
  end
end
