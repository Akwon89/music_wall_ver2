class Vote < ActiveRecord::Base

  belongs_to :user
  belongs_to :track

  after_create :increase_total_votes

  after_destroy :decrease_total_votes


  def increase_total_votes
    track.total_votes += 1
    track.save
  end

  def decrease_total_votes
    track.total_votes -= 1
    track.save
  end

end