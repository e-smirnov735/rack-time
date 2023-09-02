class TimeFormatService
  def initialize(query_string)
    @query = query_string
  end

  def call
    if incorrect_formats.empty?
      TimeFormatData.new(correct?: true, data: format_string)
    else
      TimeFormatData.new(correct?: false, data: unknown_format)
    end
  end

  private

  def format_string
    res = @query.sub('format=', '').split('%2C').join('-')
    time_hash.each_key { |k| res.sub!(k, time_hash) }

    res
  end

  def unknown_format
    "Unknown time format #{incorrect_formats}"
  end

  def incorrect_formats
    incorrect = []
    formats = @query.sub('format=', '').split('%2C')

    formats.each do |format|
      incorrect << format unless time_hash.key?(format)
    end
    incorrect
  end

  def time_hash
    t = Time.now
    {
      'year' => t.year,
      'month' => t.month,
      'day' => t.mday,
      'hour' => t.hour,
      'minute' => t.min,
      'second' => t.sec
    }
  end
end

TimeFormatData = Struct.new(:correct?, :data)
