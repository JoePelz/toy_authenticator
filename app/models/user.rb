# frozen_string_literal: true

class User
  # Support for validations
  include ActiveModel::Model
  # uses bcrypt and some basic validations on the specified field (:password)
  include ActiveModel::SecurePassword
  # support for serializable_hash, based on the attributes method
  include ActiveModel::Serialization
  # support for from_json when loading a model from redis
  include ActiveModel::Serializers::JSON

  attr_accessor :username, :password_digest

  has_secure_password :password

  validates :username, :password_confirmation, presence: true
  validate :unique_username
  validates(
    :password,
    length: { minimum: 5 },
    # https://github.com/bdmac/strong_password/blob/v0.0.10/README.md
    password_strength: {
      use_dictionary: true,
      min_entropy: 18
    }
  )

  def attributes=(hash)
    hash.each do |key, value|
      send("#{key}=", value)
    end
  end

  def attributes
    {
      'username' => nil,
      'password_digest' => nil
    }
  end

  def serialize
    serializable_hash(only: :username)
  end

  def self.find_by(username:)
    attrs = RedisInstance.instance.get(username)
    return nil if attrs.blank?

    new.from_json(attrs)
  end

  def save
    return false unless valid?

    RedisInstance.instance.set(username, to_json, ex: 30) == RedisInstance::SUCCESS
  end

  private

  def unique_username
    return if RedisInstance.instance.get(username).nil?

    errors.add(:username, 'must be unique')
  end
end
