# Base main
class BaseController < Sinatra::Base
  LIMIT = 100

  configure do
    set :json_encoder, Oj
  end

  before do
    content_type :json
  end

  def render(status: 200, meta: {}, serializer_class_name: 'Lesson')
    raise ArgumentError, 'Missing block' unless block_given?

    data = yield

    response_body = Oj.dump({
                              meta:,
                              data: serializer(data, serializer_class_name:)
                            })

    [status, response_body]
  rescue StandardError => e
    [400, { error: e.message }.to_json]
  end

  def serializer(object, serializer_class_name:)
    if object.respond_to?(:map)
      # É uma coleção de objetos
      object.map { |item| serializer_class(serializer_class_name).serialize(item) }
    else
      # É um único objeto
      serializer_class(serializer_class_name).serialize(object)
    end
  end

  def paginate(collection)
    collection.page(params[:page]).per(params[:per_page])
  end

  private

  def serializer_class(name)
    Object.const_get("#{name}Serializer")
  end
end
