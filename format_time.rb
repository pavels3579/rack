class FormatTime

  TIME_FORMAT = {
                 year: "%y",
                 month: "%m",
                 day: "%d",
                 hour: "%H",
                 minute: "%M",
                 second: "%S"
                }

  def initialize(req)
    @request = req
  end

  def get_response
    if valid_url?
      get_time
    else
      invalid_url
    end
  end

  private

  def valid_url?
    @request.path == '/time' && @request.params["format"]
  end

  def invalid_url
    make_response(404, "Unknown url")
  end

  def get_time
    time_formats = @request.params["format"]
    time_array = time_formats.split(',')

    t = Time.now
    result = [];
    mistakes = []

    time_array.each do |f|
      if TIME_FORMAT[f.to_sym]
        result << t.strftime(TIME_FORMAT[f.to_sym])
      else
        mistakes << f
      end
    end

    if mistakes.size > 0
      body_str = unknowm_format(mistakes)
      return make_response(400, body_str)
    end

    body_str = result.join("-")
    make_response(200, body_str)
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def make_response(status, body)
    [status, headers, get_body(body)]
  end

  def get_body(str)
    #["Welcome aboard!\n"]
    ["#{str}\n"]
  end

  def unknowm_format(formats)
    "Unknown time format [#{formats.join(',')}]"
  end

end
