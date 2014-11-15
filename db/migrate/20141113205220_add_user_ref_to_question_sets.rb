class AddUserRefToQuestionSets < ActiveRecord::Migration
  def change
    add_reference :question_sets, :user, index: true
  end
end
