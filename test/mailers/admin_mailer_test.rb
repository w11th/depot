require 'test_helper'

class AdminMailerTest < ActionMailer::TestCase
  test "exception_occured" do
    exception = Exception.new('test exception')
    mail = AdminMailer.exception_occured(exception)
    assert_equal "Exception Occured During Running", mail.subject
    assert_equal ["w.eleventh@gmail.com"], mail.to
    assert_equal ["depot_app"], mail.from
    assert_match exception.to_s, mail.body.encoded
  end
end
