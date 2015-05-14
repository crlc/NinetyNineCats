class Session < ActiveRecord::Base
  validates :session_token, :user_id, presence: true
  belongs_to :user

  geocoded_by :remote_ip
  after_validation :geocode

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode

  def browser
    UserAgent.parse(http_user_agent).browser
  end

  def platform
    UserAgent.parse(http_user_agent).platform
  end
end
