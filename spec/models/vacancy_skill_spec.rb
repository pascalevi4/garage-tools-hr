require 'rails_helper'

RSpec.describe VacancySkill, type: :model do
  it { should belong_to(:vacancy) }
  it { should belong_to(:skill) }
end
