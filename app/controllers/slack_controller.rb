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
  params.require(:slack).permit(:text, :user_id)
end

def verify_slack_token
  puts Rails.application.secrets.slack_token.to_s
  puts params[:token].to_s
  render nothing: true, status: :forbidden and return unless Rails.application.secrets.slack_token.to_s == params[:token].to_s
end

def exclude_seffy
  render nothing: true, status: :forbidden and return if Rails.application.secrets.seffy_user_id == params[:user_id]
end