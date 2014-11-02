class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :pip
      t.references :choice, index: true

      t.timestamps
    end
  end
end
