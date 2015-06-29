class AddSlackUserIdToFacts < ActiveRecord::Migration
  def change
    add_column :facts, :user_id, :string
  end
end
