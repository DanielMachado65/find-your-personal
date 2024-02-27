require_relative 'controller/base_controller'

# App main
class App < BaseController
  get '/' do
    'Health check'
  end
end
