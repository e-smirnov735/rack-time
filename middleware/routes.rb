class Routes
  def initialize(app)
    @app = app
  end

  def call(env)
    status, header, body = @app.call(env)

    [status, header, body]
  end
end
