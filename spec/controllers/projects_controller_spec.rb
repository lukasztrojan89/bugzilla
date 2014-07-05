require 'spec_helper'

describe ProjectsController do

  before :each do
    sign_in user
  end

  let(:user) { create(User) }

  describe 'GET#index' do
    context 'when user sign in' do
      let!(:member) { create(Member, name: 'mem', email: 'mem@o.pl') }
      let!(:project) { create(Project, title: 'dd12', user_id: user.id) }
      it 'render projects for current user' do
        get :index
        response.should render_template :index
        expect(Project.all.count).to eq 1
        expect(assigns(:projects)).to include(project)
      end
    end
  end

  describe 'GET#new' do
    it 'render new' do
      get :new
      response.should render_template :new
    end
  end

  describe 'POST#create' do
    it 'creates project' do
      expect { post :create, project: {title: 'title'} }.to change { Project.count }.by(1)
    end
    it 'validate when title is blank' do
      post :create, project: {title: ''}
      expect(response.status).to eq 422
    end
  end

  describe 'DELETE#destroy' do
    let!(:project) { create(Project, title: 'dd1', user_id: user.id) }
    it 'destroy project' do
      delete :destroy, id: project.id
      expect(Project.count).to eq 0
    end
  end

  describe 'GET#show' do
    let!(:project) { create(Project, title: 'dd1', user_id: user.id) }
    it 'show project'do
      get :show , id: project.id
      response.should render_template :show
      expect(project.title).to eq 'dd1'
    end
  end

  describe 'PUT#update' do
    let!(:project) { create(Project, title: 'dd1', user_id: user.id) }
    it 'update title' do
    put :update, id: project.id, project:{title: 'dd2'}
      expect(project.reload.title).to eq 'dd2'
    end
    it 'validate when title is blank' do
      put :update, id: project.id, project:{title: ''}
      expect(response.status).to eq 422
      expect(project.title).to eq 'dd1'
    end
  end

end
