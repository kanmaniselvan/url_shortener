class ShortenUrl < ApplicationRecord
  SHORT_CODE_SAVE_REGEX = /^[0-9a-zA-Z_]{2,6}$/

  belongs_to :user

  validates :url, :short_code, :user_id, presence: true
  validates_uniqueness_of :short_code

  before_save :validate_short_code

  def has_valid_short_code?
    self.short_code.to_s.match(SHORT_CODE_SAVE_REGEX)
  end

  # Returns uniq short_code which matches ^[0-9a-zA-Z_]{6}$ pattern
  def generate_short_code
    short_code = SecureRandom.urlsafe_base64(4)

    # It's possible for the short_code to have '-' character or the short_code might already exist.
    # On such cases, do the regeneration.
    if short_code.match(SHORT_CODE_SAVE_REGEX).blank? || ShortenUrl.where(short_code: short_code).present?
      return self.generate_short_code
    end

    short_code
  end

  def update_last_seen_and_redirect_count
    self.last_seen_date = DateTime.now
    self.redirect_count += 1

    self.save!
  end

  private
  def validate_short_code
    return if self.has_valid_short_code?

    self.short_code = self.generate_short_code
  end
end
