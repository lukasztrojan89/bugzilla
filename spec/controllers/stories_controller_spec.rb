require 'spec_helper'

describe StoriesController do
  before :each do
    sign_in user
  end

  let(:user) { create(User) }
  let!(:project) { create(Project, title: 'formember', user_id: user.id) }
  let!(:story){create(Story,project_id: project.id)}

  describe 'GET#new' do
    it 'render new' do
      get :new , project_id: project.id
      response.should render_template :new
      expect(story.name).to eq 'new'
    end
  end

  describe 'GET#edit' do
    it 'render edit_project' do
      get :edit, project_id: project.id, id: story.id
      response.should render_template :edit
    end
  end

  describe 'POST#create' do
    it 'creates story' do
      expect {post :create, project_id: project.id, story:{name: 'new created name',description: 'first description' } }.to change{Story.count}.by(1)
    end

    it 'validate story when name is blank' do
      post :create, project_id: project.id, story:{name: '',description: 'first description' }
      expect(response.status).to eq 422
    end

    it 'validate story when description is blank' do
      post :create, project_id: project.id, story:{name: 'new created name2',description: ''}
      expect(response.status).to eq 422
    end
  end

  describe 'PUT#update' do
    it 'update story name' do
      request.env["HTTP_REFERER"] = "where_i_came_from"
      put :update, id: story.id, project_id: project.id, story:{ name:'new updated name'}
      expect(story.reload.name).to eq 'new updated name'
      response.should redirect_to "where_i_came_from"
    end

    it 'validate when updating story description is blank' do
      put :update, id: story.id, project_id: project.id, story:{ description:''}
      expect(response.status).to eq 422
    end
  end

  describe 'GET#show' do
    let!(:project22) { create(Project, title: 'formember2', user_id: user.id) }
    it 'render show' do
      get :show , project_id: project22.id, id: story.id
      response.should render_template :show
      expect(story.name).to eq 'new'
    end
  end

  describe 'DELETE#destroy' do
  it 'destroy story' do
      expect{ delete :destroy, id: story.id, project_id: project.id }.to change { Story.count }.by(-1)
    end
  end

end