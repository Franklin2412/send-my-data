class ReceiverController < ApplicationController
  #do not use this on production. this is just for local curl request.
  skip_before_filter :verify_authenticity_token, only: [:success, :failure]

  def success
    # render text: "Just returning the post params #{params}"
    # render js: "PayU.onSuccess(#{params})"
    render js: "PayU.onSuccess();"
  end

  def failure
    # render text: "Just returning the post params #{params}"
    # render js: "PayU.onFailure(#{params})"
    render js: "PayU.onFailure();"
  end
end
