# boot.rb

require 'sinatra'
require 'zeitwerk'
require 'mongoid'
require 'nokogiri'
require 'open-uri'
require 'pry' if development?
require 'oj'
require 'securerandom'
require 'sinatra/reloader' if development?
require 'dotenv'

# Gerar a chave de sessão
File.open('.session.key', 'w') { |f| f.write(SecureRandom.hex(32)) }
Dotenv.load

# Configurar Zeitwerk Loader
loader = Zeitwerk::Loader.new
loader.push_dir('app/lib')
loader.push_dir('app/models')
loader.push_dir('app/workers')
loader.push_dir('app/serializer')
loader.push_dir('app/')
loader.setup

# Configurar Mongoid
Mongoid.load!(File.join(File.dirname(__FILE__), 'config', 'mongoid.yml'))

# Configurar Oj
Oj.default_options = { mode: :compat, encoding: 'utf-8' }
