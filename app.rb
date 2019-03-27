class App

  def call (env)
    request = Rack::Request.new(env)
    formater = FormatTime.new(request)

    return invalid_url unless formater.valid_url?

    result = formater.get_time

    if result[:valid]
      make_response(result[:status], result[:body])
    else
      make_response(result[:status], unknowm_format(result[:body]))
    end

  end

  private

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def make_response(status, body)
    [status, headers, ["#{body}\n"]]
  end

  def unknowm_format(formats)
    "Unknown time format [#{formats.join(',')}]"
  end

  def invalid_url
    make_response(404, "Unknown url")
  end

end
