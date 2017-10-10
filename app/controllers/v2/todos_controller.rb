class V2::TodosController < ApplicationController
  def index
    json_response({ message: 'API V2 will be here'})
  end
end
