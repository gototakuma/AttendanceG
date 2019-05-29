class Attendance < ApplicationRecord
  belongs_to :user
  validates :worked_on, presence: true
  
  
  validate :finished_at_st_blank
    def finished_at_st_blank
      if started_at.blank? && finished_at.present?
       errors.add(:finished_at, "出勤時間がありません。")
      end
    end
end  