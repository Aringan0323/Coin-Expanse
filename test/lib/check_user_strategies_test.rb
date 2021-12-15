require "test_helper"

class CheckUserStrategiesTest < ActiveSupport::TestCase

    setup do
        @user = User.first
        CoinExpanse::Application.load_tasks
        Rake::Task['strats:check_user_strategies'].invoke
    end


end