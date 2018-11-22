module Response
  def json_response(object, status = :ok)
    render json: object.to_json(:include=>[:user]), status: status
  end

  def json_response_rating(object, status = :ok)
    render json: object, status: status
  end
end