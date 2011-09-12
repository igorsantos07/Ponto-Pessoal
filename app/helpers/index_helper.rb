PontoPessoal.helpers do

  def greeting name = nil
    greeting = case Time.now.hour
      when 00..11 then 'Bom dia'
      when 12..17 then 'Boa tarde'
      when 18..23 then 'Boa noite'
    end

    if name.nil? then greeting+'!' else "#{greeting}, #{name}!" end
  end

end