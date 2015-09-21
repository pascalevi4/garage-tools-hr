require 'rails_helper'

RSpec.describe Api::SkillsController, type: :controller do

  describe 'GET index' do

    before do
      @skills = []
      5.times do
        @skills << FactoryGirl.create(:skill)
      end
      @skills << FactoryGirl.create(:skill, title: 'js')
      subject
    end

    context 'without params' do
      subject { get :index }
      it 'returns an array of skill titles' do
        JSON.parse(response.body).should =~ @skills.map(&:title)
      end
    end

    context 'without params' do
      subject { get :index, q: 'j' }
      it 'returns an array of skill titles started by j' do
        JSON.parse(response.body).should =~ ['js']
      end
    end
  end

end
