require 'rails_helper'

RSpec.describe Skill, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_uniqueness_of(:title) }

  it { should have_many(:vacancy_skills) }
  it { should have_many(:vacancies).through(:vacancy_skills) }

  it { should have_many(:resume_skills) }
  it { should have_many(:resumes).through(:resume_skills) }
end
