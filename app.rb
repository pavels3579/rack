class App

  def call (env)
    request = Rack::Request.new(env)
    formater = FormatTime.new(request)
    formater.get_response
  end

end
