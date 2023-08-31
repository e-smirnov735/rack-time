class App
  def call(env)
    query_string = env['QUERY_STRING']
    incorrect_formats = check_formats(query_string)

    result(incorrect_formats, query_string)
  end

  private

  def result(incorrect_formats, query_string)
    if incorrect_formats.empty?
      [200, { 'Content-Type' => 'text/plain' }, [format_string(query_string)]]
    else
      [400, { 'Content-Type' => 'text/plain' }, ["Unknown time format #{incorrect_formats}"]]
    end
  end

  def format_string(query)
    res = query.sub('format=', '').split('%2C').join('-')
    time_hash.each_key { |k| res.sub!(k, time_hash) }

    res
  end

  def check_formats(query)
    incorrect = []
    formats = query.sub('format=', '').split('%2C')

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
