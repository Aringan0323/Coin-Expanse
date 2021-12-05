require "test_helper"

class CheckUserStrategiesTest < ActiveSupport::TestCase

    setup do
        @user = User.first
        BlockTrade::Application.load_tasks
        # BlockTrade::Application.load_utils
        Rake::Task['strats:check_user_strategies'].invoke
    end


end