require 'rails_helper'

RSpec.describe Vacancy, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:expires_at) }
  it { should validate_presence_of(:salary) }
  it { should validate_presence_of(:contacts) }

  it { should validate_numericality_of(:salary) }

  it { should have_many(:vacancy_skills) }
  it { should have_many(:skills).through(:vacancy_skills) }
end
