PontoPessoal.controllers :workday do |controller|

  def controller.this_week account
    now = Time.now
    if now.wday >= 1
      monday = now - (now.wday-1).day
      friday = now - (now.wday-5).day
    else
      monday = now - 6.day
      friday = now - 2.day
    end

    days = Workday.find_all_by_account_id_and_day account[:id], (monday-1.day)..friday
    ordered_days = []
    days.each do |day|
      ordered_days[day.day.wday-1] = day
    end
    ordered_days
  end

	get :index do
		redirect url(:workday, :today)
	end

	get :today, :map => '/hoje' do
    now = Time.now
    time = {
      :enter      => Time.get_time(0)..Time.get_time(11,59,59),
      :go_lunch   => Time.get_time(12)..Time.get_time(12,29,59),
      :back_lunch => Time.get_time(12,30)..Time.get_time(13,29,59),
      :out        => Time.get_time(13,30)..Time.get_time(23,59,59),
    }

    @all_buttons = [
      {:label => 'Entrada', :status => :enter},
      {:label => 'Almoçar', :status => :go_lunch},
      {:label => 'Volta do almoço', :status => :back_lunch},
      {:label => 'Saída', :status => :out}
    ]

    likely_button = case Time.now
      when time[:enter]      then :enter
      when time[:go_lunch]   then :go_lunch
      when time[:back_lunch] then :back_lunch
      when time[:out]        then :out
    end

    @other_buttons = @all_buttons.reject {|button| button[:status] == likely_button}
    @likely_button = (@all_buttons - @other_buttons)[0]

    @this_week = controller.this_week current_account

		render '/workday/today'
	end

  post :set, :map => '/marcar/:status' do
    now = Time.now
    wd = Workday.find_by_account_id_and_day current_account.id, now.strftime(settings.iso_date)
    if !wd then wd = Workday.new({:account_id => current_account.id, :day => now.strftime(settings.iso_date)}) end
    wd.attributes = {params[:status] => now.strftime(settings.simple_time)}
    ap wd
    wd.save

    redirect url(:workday, :today)
  end

end