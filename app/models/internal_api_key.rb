# frozen_string_literal: true

class InternalAPIKey
  include ActiveModel::Model

  # CRUD and DB persistence for this class is out of scope for this demo
  # Also, `value` should be hashed as a secret instead of plaintext.
  # Hashing is more complicated here, because still need to search by value
  # so you need to make an API key into 2 parts, an unhashed part for finding, and a hashed part for authenticating.
  # Like a username and password joined together.
  KEYS = [
    { id: 1, value: 'valid-key', expires_at: nil }.freeze,
    { id: 2, value: 'expired-key', expires_at: Time.zone.local(2002, 5, 26, 11, 30, 59) }.freeze
  ].freeze

  attr_accessor :id, :value, :expires_at

  def self.find_by(**kwargs)
    attrs = self::KEYS.detect do |key|
      key.slice(*kwargs.keys) == kwargs
    end
    return nil unless attrs

    new(attrs)
  end

  def active?
    return true if expires_at.nil?

    Time.current <= expires_at
  end
end
