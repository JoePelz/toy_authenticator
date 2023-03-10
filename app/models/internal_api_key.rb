class InternalAPIKey
  include ActiveModel::Model

  # CRUD and DB persistence for this class is out of scope for this demo
  # Also, value should be hashed instead of plaintext.
  KEYS = [
      { id: 1, value: 'valid-key', expires_at: nil },
      { id: 2, value: 'expired-key', expires_at: 1.hour.ago }
  ]

  attr_accessor :id, :value, :expires_at

  def self.find_by(**kwargs)
    new(self::KEYS.detect do |key|
      key.slice(*kwargs.keys) == kwargs
    end)
  end

  def active?
    return true if expires_at.nil?

    Time.current <= expires_at
  end
end