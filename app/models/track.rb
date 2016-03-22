class Track < ActiveRecord::Base

  belongs_to :user

  validates :title, presence: true, length: { maximum: 40 }
  validates :artist, presence: true, length: { maximum: 40 }
  validate :url_checker, if: :url

  # after_save :add_user_id

  def url_checker
    errors.add(:invalid_url, ": url is invalid") unless url =~ /\A^(?:ftp|http|https):\/\/(?:[\w\.\-\+]+:{0,1}[\w\.\-\+]*@)?(?:[a-z0-9\-\.]+)(?::[0-9]+)?(?:\/|\/(?:[\w#!:\.\?\+=&%@!\-\/\(\)]+)|\?(?:[\w#!:\.\?\+=&%@!\-\/\(\)]+))?$\Z/i || url == ""
  end

  # def add_user_id

  # end
  
end