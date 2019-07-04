class Attendance < ApplicationRecord
  belongs_to :user
  validates :worked_on, presence: true
  validates :update_box, acceptance: true
  
  enum approval: {'なし'=> 0, '申請中'=> 1, '承認'=> 2, '否認'=> 3}, _prefix: true
  enum approval_at: {'なし'=> 0, '申請中'=> 1, '承認'=> 2, '否認'=> 3}, _prefix: true
  enum approval_mo: {'なし'=> 0, '申請中'=> 1, '承認'=> 2, '否認'=> 3}, _prefix: true
  
  validate :finished_at_st_blank
    def finished_at_st_blank
      if started_at.blank? && finished_at.present?
       errors.add(:finished_at, "出勤時間がありません。")
      end
    end
    
    
  validate :finished_at_started_faster
    def finished_at_started_faster
      if  started_at.present? && finished_at.present?
        if started_at > finished_at
          errors.add(:finished_at, "出勤時間の方が早いです。")
        end
      end
    end
  
  validate :finished_be_st_blank
  validate :finished_be_started_faster
  
  def finished_be_st_blank
    errors.add(:started_be, "が必要です") if started_be.blank? && finished_be.present?
  end
  
  def started_be_st_blank
    errors.add(:finished_be, "が必要です") if started_be.present? && finished_be.blank?
  end
    
  def finished_be_started_faster
    if started_be.present? && finished_be.present?
      errors.add(:started_be, "より早い退勤時間は無効です") if started_be > finished_be
    end
  end
end  