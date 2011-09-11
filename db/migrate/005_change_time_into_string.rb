class ChangeTimeIntoString < ActiveRecord::Migration

  @fields = [:enter, :go_lunch, :back_lunch, :out]

  def self.up
    @fields.each do |field|
      change_column :workdays, field, :char, :limit => 4
    end
  end

  def self.down
    @fields.each do |field|
      change_column :workdays, field, :char, :limit => 4
    end
  end
  
end
