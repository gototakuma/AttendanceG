class User < ApplicationRecord
  has_many :attendances, dependent: :destroy
  before_save {self.email = email.downcase }
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: {minimum: 6 },allow_nil: true
  
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|

      obj = new
      obj.attributes = row.to_hash.slice(*updatable_attributes)

      obj.save!
    end
  end

  def self.updatable_attributes
    ["name","email","belongs","code","card_id",
    "password","password_confirmation",
    "basic_time","work_time","finish_time","admin","instructor"]
  end

end