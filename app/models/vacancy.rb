class Vacancy < ActiveRecord::Base
  has_many :vacancy_skills, dependent: :destroy
  has_many :skills, through: :vacancy_skills

  validates :title, presence: true
  validates :expires_at, presence: true
  validates :salary, presence: true, numericality: true
  validates :contacts, presence: true
end
