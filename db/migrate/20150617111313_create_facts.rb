class CreateFacts < ActiveRecord::Migration
  def change
    create_table :facts do |t|
      t.text :fact

      t.timestamps
    end
  end
end
