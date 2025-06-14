class CreatePets < ActiveRecord::Migration[8.0]
  def change
    create_table :pets do |t|
      t.string :pet_type, null: false
      t.string :tracker_type, null: false
      t.integer :owner_id, null: false
      t.boolean :in_zone, default: true

      t.timestamps
    end
  end
end
