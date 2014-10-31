class CreateQuestionFormats < ActiveRecord::Migration
  def change
    create_table :question_formats do |t|
      t.string :name

      t.timestamps
    end
  end
end
