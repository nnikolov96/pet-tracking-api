class CreateCatProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :cat_profiles do |t|
      t.references :pet, null: false, foreign_key: true
      t.boolean :lost_tracker, null: false, default: false

      t.timestamps
    end
  end
end
