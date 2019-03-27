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

  def valid_url?
    @request.path == '/time' && @request.params["format"]
  end

  def get_time
    time_formats = @request.params["format"]
    time_array = time_formats.split(',')

    t = Time.now

    res = time_array.partition { |f| !TIME_FORMAT[f.to_sym].nil? }
    correct = res.first
    mistakes = res.last

    return { status: 400, body: mistakes, valid: false} if mistakes.size > 0

    result = []
    correct.each { |f| result << TIME_FORMAT[f.to_sym] }

    result = t.strftime(result.join("-"))

    return { status: 200, body: result, valid: true }
  end

end
