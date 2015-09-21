require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  describe 'GET index' do
    subject { get :index }

    it { should be_success }
  end
end
