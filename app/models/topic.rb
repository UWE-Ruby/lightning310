class Topic < ActiveRecord::Base
  belongs_to :student, class_name: User
  scope :approved, -> { where(approved: true) }
  scope :pending_approval, -> { where(approved: [false, nil]) }
  scope :completed, -> { where.not(completed_date: nil) }
  scope :not_completed, -> { where(completed_date: nil) }

  validates :student, :title, :description, :proposed_date, presence: true
end
