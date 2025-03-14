module ResponseHelper
  def response_as_json(str = nil)
    str ||= response.body
    JSON.parse(str, symbolize_names: true)
  end
end
