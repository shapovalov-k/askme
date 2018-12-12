require 'openssl'

class User < ApplicationRecord
  ITERATIONS = 20000
  DIGEST = OpenSSL::Digest::SHA256.new
  VALID_EMAIL = /\A\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}\z/
  VALID_USERNAME = /[a-zA-Z0-9_]/

  attr_accessor :password

  has_many :questions

  validates :username, format: { with: VALID_USERNAME }, length: { maximum: 40 }

  validates :email, :username, presence: true
  validates :email, :username, uniqueness: true
  validates :email, format: { with: VALID_EMAIL }

  validates :password, presence: true, on: :create
  validates_confirmation_of :password

  before_validation :username_downcase

  def username_downcase
    username.downcase!
  end

  before_save :encrypt_password

  def encrypt_password
    if password.present?
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

      self.password_hash = User.hash_to_string(
          OpenSSL::PKCS5.pbkdf2_hmac(
              password, password_salt, ITERATIONS, DIGEST.length, DIGEST
          )
      )
    end
  end

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    user = find_by(email: email)

    return nil unless user.present?

    hashed_password = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(
            password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST
        )
    )

    return user if user.password_hash == hashed_password

    nil
  end
end