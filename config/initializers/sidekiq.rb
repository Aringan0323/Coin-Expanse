
if Rails.env.production?
    Sidekiq.configure_client do |config|
      config.redis = { url: ENV['REDISTOGO_URL'], size: 5}
    end
    Sidekiq.configure_server do |config|
      config.redis = { url: ENV['REDISTOGO_URL']}
    end
else
    Sidekiq.configure_server do |config|
        config.redis = { url: 'redis://localhost:6379/0'}
    end

    Sidekiq.configure_client do |config|
        config.redis = { url: 'redis://localhost:6379/0'}
    end
end