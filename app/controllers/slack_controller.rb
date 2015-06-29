class SlackController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :verify_slack_token
  before_filter :exclude_seffy

  def create
    @fact = Fact.new(slack_params)
    respond_to do |format|
      if @fact.save
        format.json { render text: "'#{@fact.text}' was saved - FACT" }
      else
        format.json { render text: "Error saving '#{@fact.text}', because: #{@fact.errors.full_messages} - FACT", status: :unprocessable_entity }
      end
    end
  end
end

private
def slack_params
  params.permit(:text, :user_id)
end

def verify_slack_token
  verified_token = slack_params[:token].to_s.strip! == Rails.application.secrets.slack_token.to_s.strip!
  render nothing: true, status: :forbidden and return unless verified_token
end

def exclude_seffy
  verifed_is_seffy = Rails.application.secrets.seffy_user_id.to_s.strip! == slack_params[:user_id].to_s.strip!
  render nothing: true, status: :forbidden and return if verifed_is_seffy
end