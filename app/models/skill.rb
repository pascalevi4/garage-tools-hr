class Skill < ActiveRecord::Base
  has_many :vacancy_skills, dependent: :destroy
  has_many :vacancies, through: :vacancy_skills

  has_many :resume_skills, dependent: :destroy
  has_many :resumes, through: :resume_skills

  validates :title, presence: true, uniqueness: true
end
