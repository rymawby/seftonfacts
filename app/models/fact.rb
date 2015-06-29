class Fact < ActiveRecord::Base
  validates_presence_of :text, :user_id

end
