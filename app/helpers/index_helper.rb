PontoPessoal.helpers do

  def greeting name
    greeting = case Time.now.hour
      when 00..11 then 'Bom dia'
      when 12..17 then 'Boa tarde'
      when 18..23 then 'Boa noite'
    end

    "#{greeting}, #{name}!"
  end

end