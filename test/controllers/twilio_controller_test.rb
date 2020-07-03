require 'test_helper'

class TwilioControllerTest < ActionDispatch::IntegrationTest
  test "should get incoming" do
    get twilio_incoming_url
    assert_response :success
  end

end
