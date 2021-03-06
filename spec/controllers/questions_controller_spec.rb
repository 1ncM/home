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
    let(:question) { create(:question) }

    it 'assigns a new Question to @question' do
      get :new
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'render new view' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context 'with valid data' do
      it 'saves the new question in the database' do
        expect { post :create, params: { question: attributes_for(:question)} }.to change(Question, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, params: { question: attributes_for(:question) }
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'with invalid data' do
      it 'does not save the question' do
        expect { post :create, params: { question: attributes_for(:invalid_question) }}.to_not change(Question, :count)
      end

      it 'render new view' do
        post :create, params: { question: attributes_for(:invalid_question) }
        expect(response).to render_template :new
      end
    end
  end
end