class OneClickPaymentHashController < ApplicationController
  skip_before_action :verify_authenticity_token

  def get_merchant_hashes
    result = {}
    result[:status] = '0'

    if result[:data] = MerchantHash.where(merchant_key: params[:merchant_key], user_credentials: params[:user_credentials]).pluck(:card_token, :merchant_hash)
      result[:message] = 'Merchant hash fetched successfully'
    else
      result[:message] = 'No data found'
    end
    render json: result
  end

  def store_merchant_hash
    result = {}
    if MerchantHash.find_or_create_by! one_click_payment_params
      result[:status] = '0'
      result[:message] = 'Card token and merchant hash successfully added'
    else
      result[:status] = '1'
      result[:message] = 'Something went wrong could not add card token and merchant hash.'
    end

    render json: result
  end

  def delete_merchant_hash
    result = {}
    if MerchantHash.find_by(card_token: params[:card_token]).destroy
      result[:status] = '0'
      result[:message] = 'Card token successfully removed'
    else
      result[:status] = '1'
      result[:message] = 'Something went wrong while removing card token'
    end
    render json: result
  end

  private

  def one_click_payment_params
    params.permit(:merchant_key, :user_credentials, :card_token, :merchant_hash)
  end
end
