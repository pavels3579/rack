class FormatTime

  TIME_FORMAT = {
                 year: "%y",
                 month: "%m",
                 day: "%d",
                 hour: "%H",
                 minute: "%M",
                 second: "%S"
                }

  def initialize(formats)
    @formats = formats
  end

  def get_time
    t = Time.now

    correct = valid_formats.map { |format| TIME_FORMAT[format.to_sym]}
    t.strftime(correct.join("-"))
  end

  def valid_formats
    @formats.select { |format| TIME_FORMAT.key?(format.to_sym) }
  end

  def invalid_formats
    @formats.reject { |format| TIME_FORMAT.key?(format.to_sym) }
  end

  def valid?
    invalid_formats.empty?
  end

end
