class BloodGlucose < ApplicationRecord
  belongs_to :user

  validates :value, presence: true, numericality: true
  validates :reading_date, presence: true

  scope :today, -> { where(reading_date: [Time.zone.now.beginning_of_day..Time.zone.now.end_of_day]) }
  scope :this_month_till, -> { where(reading_date: [Time.zone.now.beginning_of_month..Time.zone.now.end_of_day]) }
  scope :by_dates, ->(start_date, end_date) { where(reading_date: [start_date..end_date]) }
end
