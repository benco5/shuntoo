class AddResponseDigestToQuestionSets < ActiveRecord::Migration
  def change
    add_column :question_sets, :response_digest, :string
  end
end
