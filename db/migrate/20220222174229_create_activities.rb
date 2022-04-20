class CreateActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :activities do |t|
      t.string :name
      t.string :address
      t.datetime :starts_at
      t.datetime :ends_at

      t.timestamps
    end
  end
end
