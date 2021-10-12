require './app/helpers/user_helper.rb'
require 'faker'
require 'date'

User.delete_all

def generateFakeUsers

	(0..100).each do |i|

		name = Faker::Cannabis.buzzword
		password = Faker::Cannabis.strain
		binance_api_key = Faker::Cannabis.terpene

		passwordDigest = password
		encryptedBinanceApiKey = binance_api_key

		# passwordDigest = UserHelper.digest_password(password)
		# encryptedBinanceApiKey = UserHelper.digest_password(binance_api_key)

		user = User.new(
			username:name,
			passwordDigest:passwordDigest,
			encryptedBinanceApiKey: encryptedBinanceApiKey,
			userSince:DateTime.now()
		)

		return user
	end
end

generateFakeUsers


