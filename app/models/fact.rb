class Fact < ActiveRecord::Base
  require 'slack-notifier'
  validates_presence_of :text, :user_id
  after_save 'post_fact'

  def post_fact
    notifier = Slack::Notifier.new "https://hooks.slack.com/services/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"
    notifier.ping "'#{self.text}' - FACT"
  end
end
