class App
  STATUS_LIST = {
                 s200: 200,
                 s400: 400,
                 s404: 404
                }

  def call (env)

    if env["REQUEST_PATH"] != '/time'
      status = STATUS_LIST[:s404]
      body_str = "Unknown url"
      return [status, headers, body(body_str)]
    end

    if env["QUERY_STRING"][0, 7] != 'format='
      status = STATUS_LIST[:s404]
      body_str = "No string format="
      return [status, headers, body(body_str)]
    end

    time_formats = env["QUERY_STRING"][7, env["QUERY_STRING"].length-7]

    time_array = time_formats.split('%2C')

    t = Time.now
    result = [];
    mistakes = []

    time_array.each do |f|
      if f == "year"
        result << t.year.to_s
      elsif f == "month"
        result << t.month.to_s
      elsif f == "day"
        result << t.day.to_s
      elsif f == "hour"
        result << t.hour.to_s
      elsif f == "minute"
        result << t.min.to_s
      elsif f == "second"
        result << t.sec.to_s
      else
        mistakes << f
      end
    end

    if mistakes.size > 0
      status = STATUS_LIST[:s400]
      body_str = unknowm_format(mistakes)
      return [status, headers, body(body_str)]
    end

    status = STATUS_LIST[:s200]
    body_str = result.join("-")
    [status, headers, body(body_str)]
  end

  private

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def body(str)
    #["Welcome aboard!\n"]
    ["#{str}\n"]
  end

  def unknowm_format(formats)
    "Unknown time format [#{formats.join(',')}]"
  end

end
