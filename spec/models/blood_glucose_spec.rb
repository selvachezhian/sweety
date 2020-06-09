require 'rails_helper'

RSpec.describe BloodGlucose, type: :model do
  describe 'associations' do
    it { should belong_to(:user).class_name('User') }
  end

  describe 'validations' do
    it { should validate_presence_of(:value) }
    it { should validate_numericality_of(:value) }
    it { should validate_presence_of(:reading_date) }
  end

  describe 'db columns' do
    it { should have_db_column(:value) }
    it { should have_db_column(:reading_date) }
  end

  describe 'db index' do
    it { should have_db_index(:reading_date) }
  end

  describe 'scope methods' do

    before(:all) do

      user = User.create!(email: 'test@test.com', password: 'password')
      3.times do
        user.blood_glucoses.create!(value: rand(100), reading_date: Time.zone.now)
      end

      (Time.zone.now.beginning_of_month.to_date..Time.zone.now.end_of_week.to_date).to_a.each do |day|
        user.blood_glucoses.create!(value: rand(100), reading_date: day) unless day.today?
      end
    end

    it 'should return results for today' do
      expect(BloodGlucose.today.count).to eq(3)
      expect(BloodGlucose.today.first.reading_date.today?).to be_truthy
      expect(BloodGlucose.today.last.reading_date.today?).to be_truthy
    end

    it 'should return results for this month' do
      expect((Time.zone.now.beginning_of_month.to_date..Time.zone.now.end_of_month.to_date).to_a).to include(BloodGlucose.this_month_till.first.reading_date.to_date)
      expect((Time.zone.now.beginning_of_month.to_date..Time.zone.now.end_of_month.to_date).to_a).to include(BloodGlucose.this_month_till.last.reading_date.to_date)
    end

    it 'should return results for specific time' do
      start_month = Time.zone.now.beginning_of_month.to_date
      start_week = Time.zone.now.beginning_of_week.to_date
      one_week = (Time.zone.now.beginning_of_month.to_date + 1.week)
      end_week = Time.zone.now.end_of_week.to_date

      expect((start_week..end_week).to_a).to include(BloodGlucose.by_dates(start_week, end_week).first.reading_date.to_date)
      expect((start_week..end_week).to_a).to include(BloodGlucose.by_dates(start_week, end_week).last.reading_date.to_date)

      expect((start_month..one_week).to_a).to include(BloodGlucose.by_dates(start_month, one_week).first.reading_date.to_date)
      expect((start_month..one_week).to_a).to include(BloodGlucose.by_dates(start_month, one_week).last.reading_date.to_date)
    end
  end
end