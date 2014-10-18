class CreateSuites < ActiveRecord::Migration
  def change
    create_table :suites do |t|
      t.string :title

      t.timestamps
    end
  end
end
