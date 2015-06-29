class RenameFactToText < ActiveRecord::Migration
  def change
    rename_column :facts, :fact, :text
  end
end
