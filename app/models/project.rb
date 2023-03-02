class Project < ApplicationRecord
  belongs_to :user
  has_many :investments

  accepts_nested_attributes_for :investments

  validates :name,
            :description, presence: true

  def investments_total
    investments.sum(:amount)
  end

  def owner?(user)
    self.user == user
  end
end
