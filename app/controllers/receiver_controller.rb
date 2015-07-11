class ReceiverController < ApplicationController
  #do not use this on production. this is just for local curl request.
  skip_before_filter :verify_authenticity_token, only: [:success, :failure]

  def success
    render js: "PayU.onSuccess(#{params})"
  end

  def failure
    render js: "PayU.onFailure(#{params})"
  end
end
