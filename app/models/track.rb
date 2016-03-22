class Track < ActiveRecord::Base

  validates :song_title, presence: true, length: { maximum: 40 }
  validates :author, presence: true, length: { maximum: 40 }
  validate :url_checker, if: :url
  # validate :http_checker
  def url_checker
    errors.add(:invalid_url, ": url is invalid") unless url =~ /\A^(?:ftp|http|https):\/\/(?:[\w\.\-\+]+:{0,1}[\w\.\-\+]*@)?(?:[a-z0-9\-\.]+)(?::[0-9]+)?(?:\/|\/(?:[\w#!:\.\?\+=&%@!\-\/\(\)]+)|\?(?:[\w#!:\.\?\+=&%@!\-\/\(\)]+))?$\Z/i || url == ""
  end

  # def http_checker
  #   if url =~ /\A^https://\Z/i
  # end


end