class User < ApplicationRecord
  validates :email, uniqueness: true, :on => :create
  after_validation :normalize_name, on: :create
  before_save :record_gmail
  has_one :profile
  has_many :posts
  has_many :comments, as: :commentable
  accepts_nested_attributes_for :profile, update_only: true, allow_destroy: true


  # def email_uniqueness
  #   byebug
  #   validates :email, presence: true, email: true
  #   validates :email, uniqueness: true
  # end
  def normalize_name
    self.email = email.downcase
  end

  def record_gmail
    if self.email.end_with?("gmail.com")
      self.gmail = true
      # self.save
    end
  end


end
