class FormatTime

  TIME_FORMAT = {
                 year: "%y",
                 month: "%m",
                 day: "%d",
                 hour: "%H",
                 minute: "%M",
                 second: "%S"
                }

  attr_reader :invalid_formats

  def initialize(formats)
    @formats = formats
    @valid_formats, @invalid_formats = formats.partition { |format| TIME_FORMAT.key?(format.to_sym) }
  end

  def get_time
    t = Time.now

    correct = @valid_formats.map { |format| TIME_FORMAT[format.to_sym] }
    t.strftime(correct.join("-"))
  end

  def valid?
    @invalid_formats.empty?
  end

end
