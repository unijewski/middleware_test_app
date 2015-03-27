if Rails.env.production?
  Rails.application.configure do |c|
    c.middleware.use RateLimiter, limit: 200, store: Dalli::Client.new(
      (ENV['MEMCACHIER_SERVERS'] || '').split(','),
      username: ENV['MEMCACHIER_USERNAME'],
      password: ENV['MEMCACHIER_PASSWORD'],
      failover: true,
      socket_timeout: 1.5,
      socket_failure_delay: 0.2
    )
  end
end
