class Coupon < ApplicationRecord
  validate :invalid_expire_date, :invalid_coupon
  validates :code, presence: true, length: {minimum: Settings.code.minimum}
  validates :percent, presence: true,
    numericality: {less_than: Settings.percent.maximum,
                   greate_than: Settings.percent.minimum}
  validates :import, numericality: {greate_than: Settings.import.minimum},
    allow_nil: true

  scope :desc, ->{order created_at: :desc}

  def unexpired?
    expire ? expire > Time.zone.now : true
  end

  def unfull_import?
    import ? import > imported : true
  end

  private

  def invalid_expire_date
    return if expire.blank? || Time.zone.now < expire
    errors.add :expire, I18n.t("invalid_date")
  end

  def invalid_coupon
    return unless expire.blank? && import.blank?
    errors.add :coupon, I18n.t("invalid_coupon")
  end
end
