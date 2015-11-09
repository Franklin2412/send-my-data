class ReceiverController < ApplicationController
  #do not use this on production. this is just for local curl request.
  skip_before_filter :verify_authenticity_token, only: [:success, :failure, :get_hash, :ios_failure, :ios_success]

  def success
    @bank_response = request.body.read
  end

  def failure
    @bank_response = request.body.read
  end

  def ios_success
    @bank_response = request.body.read
  end

  def ios_failure
    @bank_response = request.body.read
  end

  def get_hash
    render json: validate_params
  end

  private
  def sample_merchant_details
    {"gtKFFx" => "eCwWELxi", "smsplus" => "1b1b0", "0MQaQP" => "13p0PXZk", "PqvxqV" => "6SPh4Ulq", "obScKz" => "Ml7XBCdR", "DXOF8m" => "2Hl5U0En"}
  end

  def mandatory_params
    ['key', 'txnid', 'amount', 'productinfo', 'firstname', 'email', 'udf1', 'udf2', 'udf3', 'udf4', 'udf5']
  end

  def validate_params
    hash_string = ''
    message = 'successfully generated hash'
    status = 0
    result = {}
    if sample_merchant_details.key? params['key']
      mandatory_params.each do |mandatory_param|
        if params[mandatory_param]
          hash_string << params[mandatory_param] << '|'
        else
          message =  "Mandatory param #{mandatory_param} is missing. could not calculate payment hash"
          status = 1
        end
      end
        #lets add payment hash
        # lets add salt  and then calculate the hash
      puts 'hash_string out: ' + hash_string
        result[:payment_hash] = calculate_payment_hash hash_string << '|||||' << sample_merchant_details[params['key']]  if status == 0

      #calculated other hashes
      if params[:user_credentials]
        result[:payment_related_details_for_mobile_sdk_hash] = calculate_hash 'payment_related_details_for_mobile_sdk'
        result[:delete_user_card_hash] = calculate_hash 'delete_user_card'
        result[:edit_user_card_hash] = calculate_hash 'edit_user_card'
        result[:save_user_card_hash] = calculate_hash 'save_user_card'
        result[:get_user_cards_hash] = calculate_hash 'get_user_cards'
      else
        result[:payment_related_details_for_mobile_sdk_hash] = calculate_hash 'payment_related_details_for_mobile_sdk', 'default'
      end

      result[:check_offer_status_hash] = calculate_hash 'check_offer_status', params['offer_key'] if params['offer_key']
      result[:check_isDomestic_hash] = calculate_hash 'check_isDomestic', params['card_bin'] if params['card_bin']
      result[:vas_for_mobile_sdk_hash] = calculate_hash 'vas_for_mobile_sdk', 'default'
      result[:get_merchant_ibibo_codes_hash] = calculate_hash 'get_merchant_ibibo_codes', 'default'

    else
      message = "Could not generate hash for #{params[:key] ||= "nil" }, please try with any one payu test credentials #{sample_merchant_details}"
      status = 0
    end
    result[:status] = status
    result[:message] = message
    result
  end

  def calculate_payment_hash hash_string
    puts hash_string
    # apply sha 512.
    Digest::SHA2.new(512).hexdigest(hash_string)
  end

  def calculate_hash command, var1=params['user_credentials']
    Digest::SHA2.new(512).hexdigest(params['key'] + '|' + command + '|' + var1 + '|' + sample_merchant_details[params['key']])
  end
end
