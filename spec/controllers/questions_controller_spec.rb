require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  describe 'GET #index' do
    let(:questions) { create_list(:question, 2) }

    before { get :index }

    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #new' do
    it 'assigns a new Question to @question' do
      question = create(:question)
      get :new
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'render new view' do
      get :new
      expect(response).to render_template :new
    end
  end
  # describe 'POST #create' do
  #   context 'with valid data' do
  #     it 'присвоить переменной вновь созданный вопрос' do
  #       question = create(:question)
  #       post :create, params: { title: '123', body: '321' }
  #       expect(assigns(question)).to be_a_new(question)
  #     end
  #
  #     it 'redirect show view' do
  #       question = create(:question)
  #       post :create, params: { title: '123', body: '321' }
  #       expect(response).to redirect_to question
  #     end
  #   end
  # end
end