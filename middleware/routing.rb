class Routing
  def initialize(app)
    @app = app
  end

  def call(env)
    status, header, body = @app.call(env)

    request = Rack::Request.new(env)

    if request.path == '/time'
      [status, header, body]
    else
      [404, {}, ['Not Found']]
    end
  end
end
