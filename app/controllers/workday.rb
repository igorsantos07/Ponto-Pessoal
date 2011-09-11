PontoPessoal.controllers :workday do |controller|

  def controller.get_time hour, min = 0
    now = Time.now
    return Time.local now.year, now.month, now.day, hour, min
  end

	get :index do
		redirect url(:workday, :today)
	end

	get :today, :map => '/hoje' do
    now = Time.now
    time = {
      :enter      => controller.get_time(0)..controller.get_time(11,59),
      :go_lunch   => controller.get_time(12)..controller.get_time(12,30),
      :back_lunch => controller.get_time(12,31)..controller.get_time(13,30),
      :out        => controller.get_time(13,31)..controller.get_time(23,59),
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