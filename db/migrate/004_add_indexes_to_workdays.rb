class AddIndexesToWorkdays < ActiveRecord::Migration
  def self.up
    add_index :workdays, [:account_id, :day]
  end

  def self.down
    remove_index :workdays, :column => [:account_id, :day]
  end
end