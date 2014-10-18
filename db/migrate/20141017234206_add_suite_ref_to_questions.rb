class AddSuiteRefToQuestions < ActiveRecord::Migration
  def change
    add_reference :questions, :suite, index: true
  end
end
