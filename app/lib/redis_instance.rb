class RedisInstance
  # TODO: put into an environment variable or Rails.config
  # TODO: secure redis with credentials
  # TODO: use connection_pool gem for multiple threads to manage redis connections
  REDIS_URL = 'redis://localhost:6379'
  REDIS_DATABASE = 0
  OPTIONS = {
      url: REDIS_URL,
      # username: admin
      # password: P4ssw0rd!
      db: REDIS_DATABASE,
  }.freeze
  SUCCESS = 'OK'

  def self.instance
    Redis.new(OPTIONS)
  end
end
