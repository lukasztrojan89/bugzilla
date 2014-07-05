require 'spec_helper'

describe TasksController do
render_views
  before :each do
    sign_in user
  end
  let(:user) { create(User) }
  let!(:project) { create(Project, title: 'formember', user_id: user.id) }
  let!(:story){create(Story,project_id: project.id)}
  let!(:task){create(Task, story_id: story.id, text: 'new task to story')}

  describe 'GET#new' do
    it 'render new' do
      get :new, story_id: story.id
      response.should render_template :new
    end
  end

  describe 'POST#create' do
    it 'creates task' do
      expect {post :create, story_id: story.id, task:{text: 'new task to story'} }.to change{Task.count}.by(1)
    end
    it 'validate task when text is blank' do
      post :create, story_id: story.id, task:{text: ''}
      expect(response.status).to eq 422
    end
  end

  describe 'DELETE#destroy' do
    let!(:story2){create(Story,project_id: project.id, name:'n2ew',description: 'no2 description for this particular story')}
    let!(:task2){create(Task, story_id: story2.id, text: 'new2 task to story')}

    it 'destroy task' do
      request.env["HTTP_REFERER"] = "where_i_came_from"
      expect{ delete :destroy, id: task2.id, story_id: story2.id }.to change { Task.count }.by(-1)
      #response.should redirect_to "where_i_came_from"
    end
  end



end