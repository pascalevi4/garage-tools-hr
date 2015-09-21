require 'rails_helper'

RSpec.describe ResumesController, type: :controller do
  describe 'GET index' do
    subject { get :index }
    before do
      @resumes = []
      3.times { @resumes << FactoryGirl.create(:resume) }
      subject
    end

    it 'assigns resumes list' do
      assigns(:resumes).should =~ @resumes
    end
  end

  describe 'GET new' do
    subject { get :new }

    it 'assigns resume' do
      subject
      assigns(:resume).should_not be nil
    end
  end

  describe 'GET edit' do
    let(:resume) { FactoryGirl.create :resume }
    subject { get :edit, id: resume.id }

    it 'assigns resume' do
      subject
      assigns(:resume).should == resume
    end
  end

  describe 'POST create' do
    valid_attributes = {
      fio: 'example resume fio',
      state: 'busy',
      salary: 10000,
      contacts: '8(999)7777777',
      skills: 'js,ruby,css'
    }

    before do
      FactoryGirl.create :skill, title: 'js'
    end

    context 'valid params' do
      subject { post :create, resume: valid_attributes }

      it 'creates resume' do
        expect { subject }.to change(Resume, :count).by(1)
      end

      it { should redirect_to(resumes_path) }

      it 'assigns skills to resume' do
        subject
        assigns(:resume).skills.map(&:title).should =~ ['js', 'ruby', 'css']
      end

      it 'creates skills if not exists' do
        expect { subject }.to change(Skill, :count).by(2)
      end
    end

    context 'invalid params' do
      subject { post :create, resume: valid_attributes.merge({fio: ''}) }

      it 'doesn`t create resume' do
        expect { subject }.to_not change(Resume, :count)
      end

      it { should render_template(:new) }
    end
  end

  describe 'PUT update' do
    let(:resume) { FactoryGirl.create :resume }

    before do
      FactoryGirl.create :skill, title: 'js'
    end

    valid_attributes = {
      fio: 'example resume fio',
      state: 'busy',
      salary: 10000,
      contacts: '8(999)7777777',
      skills: 'js,ruby,css'
    }

    context 'valid params' do
      subject { put :update, id: resume.id, resume: valid_attributes }

      it 'upates resume' do
        subject
        resume.reload.fio.should == valid_attributes[:fio]
      end

      it { should redirect_to(resumes_path) }

      it 'assigns skills to resume' do
        subject
        resume.reload.skills.map(&:title).should =~ ['js', 'ruby', 'css']
      end

      it 'creates skills if they dont exist' do
        expect { subject }.to change(Skill, :count).by(2)
      end
    end

    context 'invalid params' do
      subject { put :update, id: resume.id, resume: valid_attributes.merge({fio: ''}) }

      it 'doesn`t update resume' do
        subject
        resume.reload.fio.should_not == ''
      end

      it { should render_template(:edit) }
    end
  end

  describe 'GET show' do
    let(:read_skill)    { FactoryGirl.create :skill }
    let(:write_skill)   { FactoryGirl.create :skill }
    let(:english_skill) { FactoryGirl.create :skill }

    let(:read_vacancy) { FactoryGirl.create :vacancy, title: 'read' }
    let(:read_write_vacancy) { FactoryGirl.create :vacancy, title: 'read write' }
    let(:english_vacancy) { FactoryGirl.create :vacancy, title: 'english' }
    let(:read_english_vacancy) { FactoryGirl.create :vacancy, title: 'read_english_vacancy' }

    let(:resume) { FactoryGirl.create :resume }

    subject { get :show, id: resume.id }

    before do
      resume.skills << [read_skill, write_skill]
      read_vacancy.skills << read_skill
      read_write_vacancy.skills << [read_skill, write_skill]
      english_vacancy.skills << english_skill
      read_english_vacancy.skills << [read_skill, english_skill]
      subject
    end

    it 'assigns full intersect vacancies' do
      assigns(:full_intersect_vacancies).should =~ [read_vacancy, read_write_vacancy]
    end

    it 'assigns partial intersect vacancies' do
      assigns(:partial_intersect_vacancies).should =~ [read_english_vacancy]
    end

    context 'there is expired vacancy' do
      before do
        expired_vacancy = FactoryGirl.create :vacancy, expires_at: 1.day.ago
        expired_vacancy.skills << [read_skill, write_skill]
      end

      it 'assigns only actual vacancies' do
        assigns(:full_intersect_vacancies).should =~ [read_vacancy, read_write_vacancy]
      end
    end
  end
end
