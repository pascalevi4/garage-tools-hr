require 'rails_helper'

RSpec.describe Resume, type: :model do
  let :resume do
    FactoryGirl.create :resume, fio: 'Иван Петрович Иванов'
  end

  it { should validate_presence_of(:fio) }
  it { should validate_presence_of(:contacts) }
  it { should validate_presence_of(:state) }
  it { should validate_presence_of(:salary) }

  it { should validate_numericality_of(:salary) }

  it { should_not allow_value('Иван1 Петрович Иванов').for(:fio) }
  it { should_not allow_value('Иван Иванов').for(:fio) }
  it { should_not allow_value('Иван').for(:fio) }
  it { should allow_value('Иван Петрович Иванов').for(:fio) }

  it { should have_many(:resume_skills) }
  it { should have_many(:skills).through(:resume_skills) }

  it 'can be free' do
    resume.free!
    resume.free?.should be true
  end

  it 'can be busy' do
    resume.busy!
    resume.busy?.should be true
  end
end
