class Track < ActiveRecord::Base

  belongs_to :user
  has_many :votes

  validates :title, presence: true, length: { maximum: 40 }
  validates :artist, presence: true, length: { maximum: 40 }
  validate :url_checker, if: :url

  def url_checker
    errors.add(:invalid_url, ": url is invalid") unless url =~ /\A^(?:ftp|http|https):\/\/(?:[\w\.\-\+]+:{0,1}[\w\.\-\+]*@)?(?:[a-z0-9\-\.]+)(?::[0-9]+)?(?:\/|\/(?:[\w#!:\.\?\+=&%@!\-\/\(\)]+)|\?(?:[\w#!:\.\?\+=&%@!\-\/\(\)]+))?$\Z/i || url == ""
  end

  
end