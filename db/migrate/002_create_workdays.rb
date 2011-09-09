class CreateWorkdays < ActiveRecord::Migration
  def self.up
    create_table :workdays do |t|
      t.date :day
      t.time :enter
      t.time :go_lunch
      t.time :back_lunch
      t.time :out
      t.references :account
    end
  end

  def self.down
    drop_table :workdays
  end
end
