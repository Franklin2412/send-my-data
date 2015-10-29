class CreateMerchantHashes < ActiveRecord::Migration
  def change
    create_table :merchant_hashes do |t|
      t.string :merchant_key
      t.string :user_credentials
      t.string :card_token
      t.string :merchant_hash

      t.timestamps null: false
    end
  end
end
