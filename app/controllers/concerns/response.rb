module Response
  def json_response(object, status = :ok)
    render json: object.to_json(:include=>[:user]), status: status
  end
end