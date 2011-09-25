class Workday < ActiveRecord::Base
  belongs_to :account

  def balance
    if @balance.nil?
      now = Time.now
      parts = {
        :enter      => (!self[:enter].nil?)? self[:enter].split(':') : [9,0],
        :go_lunch   => (!self[:go_lunch].nil?)? self[:go_lunch].split(':') : nil,
        :back_lunch => (!self[:back_lunch].nil?)? self[:back_lunch].split(':') : nil,
        :out        => (!self[:out].nil?)? self[:out].split(':') : [18,0],
      }
      enter = Time.get_time parts[:enter][0], parts[:enter][1]
      out   = Time.get_time parts[:out][0], parts[:out][1]
      lunch = (parts[:go_lunch].nil? || parts[:back_lunch].nil?)?
        Time.get_time(12) - Time.get_time(13) :
        Time.get_time(parts[:back_lunch][0], parts[:back_lunch][1]) - Time.get_time(parts[:go_lunch][0], parts[:go_lunch][1])

      # the worker will never lunch less than one hour... or at least he shouldn't
      lunch = 60*60 if lunch < 60*60

      total_time = out - enter - lunch
      @balance = {
        :hour => (total_time / 60 / 60).to_i,
        :min => (total_time / 60 % 60).to_i
      }
    end

    return @balance
  end
end
