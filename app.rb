class App

  def call (env)
    request = Rack::Request.new(env)

    return invalid_url unless request.path == '/time' && request.params["format"]

    formater = FormatTime.new(request.params["format"].split(','))

    if formater.valid?
      make_response(200, formater.get_time)
    else
      make_response(400, unknown_formats(formater.invalid_formats))
    end

  end

  private

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def make_response(status, body)
    [status, headers, ["#{body}\n"]]
  end

  def unknown_formats(formats)
    "Unknown time format [#{formats.join(',')}]"
  end

  def invalid_url
    make_response(404, "Unknown url")
  end

end
