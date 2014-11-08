require 'test_helper'

class ResponseTest < ActiveSupport::TestCase

  def setup
    @response = Response.new(choice_id: 1, pip: 1)
  end

  test "should be valid" do
    assert @response.valid?
  end

  test "choice id should be present" do
    @response.choice_id = "     "
    assert_not @response.valid?
  end

  test "pip should be present" do
    @response.pip = " "
    assert_not @response.valid?
  end

end
