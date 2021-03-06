require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  describe 'POST #create' do
    let(:question) {create(:question)}
    context 'with valid attributes' do
      it 'save the new answer in the database' do
        expect {post :create, params: { answer: attributes_for(:answer), question_id: question}}.to change(question.answers,:count).by(1)
      end
      it 'redirect to question' do
        post :create, params: { answer: attributes_for(:answer), question_id: question}
        expect(response).to redirect_to(assigns(:answer).question)
      end
    end

    context 'with invalid attributes' do
      it 'do not save in database' do
        expect {post :create, params: {answer: attributes_for(:invalid_answer), question_id: question}}.to_not change(question.answers, :count)
      end
      it 'render new view' do
        post :create, params: { answer: attributes_for(:invalid_answer), question_id: question }
        expect(response).to render_template(:new)
      end
    end
  end
end
