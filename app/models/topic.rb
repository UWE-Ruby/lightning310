class Topic < ActiveRecord::Base
  belongs_to :student, class_name: User

  default_scope { order("proposed_date ASC") }
  scope :approved, -> { where(approved: true) }
  scope :pending_approval, -> { where(approved: [false, nil]) }
  scope :completed, -> { where.not(completed_date: nil) }
  scope :not_completed, -> { where(completed_date: nil) }

  validates :student, :title, :description, :proposed_date, presence: true

  def approve!
    self.approved = true
    self.save
  end

  def complete!
    self.completed_date = Date.today
    self.save
  end
end
