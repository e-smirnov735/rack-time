require_relative 'services/time_format_service'

class App
  def call(env)
    format_data = TimeFormatService.new(env['QUERY_STRING']).call

    responce(format_data.correct?, format_data.data)
  end

  private

  def responce(is_correct, data)
    [
      is_correct ? 200 : 400,
      { 'Content-Type' => 'text/plain' },
      [data]
    ]
  end
end
