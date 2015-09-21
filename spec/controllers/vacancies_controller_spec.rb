require 'rails_helper'

RSpec.describe VacanciesController, type: :controller do
  describe 'GET index' do
    subject { get :index }
    before do
      @vacancies = []
      3.times { @vacancies << FactoryGirl.create(:vacancy) }
      subject
    end

    it 'assigns vacancies list' do
      assigns(:vacancies).should =~ @vacancies
    end
  end

  describe 'POST create' do
    valid_attributes = {
      title: 'example vacancy',
      expires_at: 20.days.from_now,
      salary: 10000,
      contacts: 'avenue, 16',
      skills: 'js,ruby,css'
    }

    before do
      FactoryGirl.create :skill, title: 'js'
    end

    context 'valid params' do
      subject { post :create, vacancy: valid_attributes }

      it 'creates vacancy' do
        expect { subject }.to change(Vacancy, :count).by(1)
      end

      it { should redirect_to(vacancies_path) }

      it 'assigns skills to vacancy' do
        subject
        assigns(:vacancy).skills.map(&:title).should =~ ['js', 'ruby', 'css']
      end

      it 'creates skills if they dont exist' do
        expect { subject }.to change(Skill, :count).by(2)
      end
    end

    context 'invalid params' do
      subject { post :create, vacancy: valid_attributes.merge({title: ''}) }

      it 'doesn`t create vacancy' do
        expect { subject }.to_not change(Vacancy, :count)
      end

      it { should render_template(:new) }
    end
  end

  describe 'PUT update' do
    let(:vacancy) { FactoryGirl.create :vacancy }

    before do
      FactoryGirl.create :skill, title: 'js'
    end

    valid_attributes = {
      title: 'example vacancy',
      expires_at: 20.days.from_now,
      salary: 10000,
      contacts: 'avenue, 16',
      skills: 'js,ruby,css'
    }

    context 'valid params' do
      subject { put :update, id: vacancy.id, vacancy: valid_attributes }

      it 'upates a vacancy' do
        subject
        vacancy.reload.title.should == valid_attributes[:title]
      end

      it { should redirect_to(vacancies_path) }

      it 'assigns skills to vacancy' do
        subject
        vacancy.reload.skills.map(&:title).should =~ ['js', 'ruby', 'css']
      end

      it 'creates skills if they dont exist' do
        expect { subject }.to change(Skill, :count).by(2)
      end
    end

    context 'invalid params' do
      subject { put :update, id: vacancy.id, vacancy: valid_attributes.merge({title: ''}) }

      it 'doesn`t update a vacancy' do
        subject
        vacancy.reload.title.should_not == ''
      end

      it { should render_template(:edit) }
    end
  end

  describe 'GET show' do
    let(:read_skill)    { FactoryGirl.create :skill }
    let(:write_skill)   { FactoryGirl.create :skill }
    let(:english_skill) { FactoryGirl.create :skill }

    let(:vacancy) { FactoryGirl.create :vacancy }

    let(:read_resume)    { FactoryGirl.create :resume }
    let(:english_resume) { FactoryGirl.create :resume }
    let(:read_write_resume) { FactoryGirl.create :resume }
    let(:read_write_english_resume) { FactoryGirl.create :resume }

    before do
      vacancy.skills << [read_skill, write_skill]

      read_resume.skills << [read_skill]
      english_resume.skills << [english_skill]
      read_write_resume.skills << [read_skill, write_skill]
      read_write_english_resume.skills << [read_skill, write_skill, english_skill]

      subject
    end

    subject { get :show, id: vacancy }

    it 'assigns vacancy' do
      assigns(:vacancy).should == vacancy
    end

    it 'assigns full_intersect_resumes' do
      assigns(:full_intersect_resumes).should =~ [read_write_resume, read_write_english_resume]
    end

    it 'assigns partial_intersect_resumes' do
      assigns(:partial_intersect_resumes).should =~ [read_resume]
    end

    context 'there is resume with state busy' do
      before do
        busy_resume = FactoryGirl.create :resume, state: :busy
        busy_resume.skills << [read_skill, write_skill]
      end

      it 'assigns only free resumes' do
        assigns(:full_intersect_resumes).should =~ [read_write_resume, read_write_english_resume]
      end
    end
  end

  describe 'GET new' do
    subject { get :new }

    it 'assigns vacancy' do
      subject
      assigns(:vacancy).should_not be nil
    end
  end

  describe 'GET edit' do
    let(:vacancy) { FactoryGirl.create :vacancy }
    subject { get :edit, id: vacancy.id }

    it 'assigns vacancy' do
      subject
      assigns(:vacancy).should == vacancy
    end
  end
end
