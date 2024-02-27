# config.ru

require_relative 'boot'

# Utilizar a chave secreta com um middleware de cookie de sessão
use Rack::Session::Cookie, secret: File.read('.session.key'), same_site: :strict, max_age: 86_400

# Mapeamento de URL
run Rack::URLMap.new(
  '/' => App
)
