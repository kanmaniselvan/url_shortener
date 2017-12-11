class ShortenUrl < ApplicationRecord
  URL_REGEX = /https?:\/\/[\S]+/
  SHORT_CODE_SAVE_REGEX = /^[0-9a-zA-Z]{2,6}$/

  belongs_to :user

  validates :url, :short_code, :user_id, presence: true
  validates_uniqueness_of :short_code

  validate :short_code_and_url

  def has_valid_short_code?
    self.short_code.to_s.match(SHORT_CODE_SAVE_REGEX)
  end

  def has_valid_url?
    self.url.to_s.match(URL_REGEX)
  end

  def update_last_seen_and_redirect_count
    self.last_seen_date = DateTime.now
    self.redirect_count += 1

    self.save!
  end

  private
  def short_code_and_url
    unless self.has_valid_short_code?
      errors.add(:short_code, "should be between 2 to 6 characters within [a-z], [A-Z], [0-9]")
    end

    unless self.has_valid_url?
      errors.add(:url, "is invalid. Valid URL ex: https://www.example.com")
    end
  end
end
