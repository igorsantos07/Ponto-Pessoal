class AddLoginToAccounts < ActiveRecord::Migration
  def self.up
		add_column :accounts, :login, :string
		add_index :accounts, :login, :unique => true
  end

  def self.down
		drop_column :accounts, :login
  end
end
