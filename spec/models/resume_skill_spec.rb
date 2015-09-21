require 'rails_helper'

RSpec.describe ResumeSkill, type: :model do
  it { should belong_to(:resume) }
  it { should belong_to(:skill) }
end
