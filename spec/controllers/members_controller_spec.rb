require 'spec_helper'

describe MembersController do
  before :each do
    sign_in user
  end
  let(:user) { create(User) }
  let!(:project) { create(Project, title: 'formember', user_id: user.id) }
  let!(:project2) { create(Project, title: 'formember2', user_id: user.id) }
  let(:member){create(Member, name: user.email, email: user.email,project_id: project2.id, projectmanager: true, confirm: true)}
  describe 'GET#new' do
    it 'render new' do
      get :new , project_id: project.id
      response.should render_template :new
      expect(project.members.first.name).to eq user.email
    end
  end

  describe 'GET#edit' do
    it 'render edit_project' do
      get :edit, project_id: project.id, id: member.id
      response.should render_template :edit
    end
  end

  describe 'POST#create' do
    it 'creates member' do
      expect {post :create, project_id: project.id, member:{name: user.email,email: user.email } }.to change{Member.count}.by(1)
    end
    it 'validate when name is blank' do
      post :create, project_id: project2.id, member:{name:'', email: 'aaa@wp.pl'}
      expect(response.status).to eq 422
    end
    it 'validate when email is blank' do
      post :create, project_id: project2.id, member:{name:'aa'}
      expect(response.status).to eq 422
    end
  end

  describe 'PUT#update' do
    it 'update member email' do
      put :update, id: member.id, project_id: project2.id, member:{ email:'member@wp.pl'}
      expect(member.reload.email).to eq 'member@wp.pl'
    end
    it 'update member name' do
      put :update, id: member.id, project_id: project2.id, member:{ name:'member@wp.pl'}
      expect(member.reload.name).to eq 'member@wp.pl'
    end
    it 'when email format is not valid' do
      put :update, id: member.id, project_id: project2.id, member:{ email: 'memberwp.pl'}
      expect(response.status).to eq 422
    end
  end

  describe 'DELETE#destroy' do
    let!(:project3) { create(Project, title: 'dd1', user_id: user.id) }
    let!(:member3){create(Member, project_id: project3.id, name: 'nowymember', email: 'nowy@email.com' )}
    it 'destroy member' do
      expect{ delete :destroy, id: member3.id, project_id: project3.id }.to change { Member.count }.by(-1)
    end
  end

  describe 'GET#confirm' do
    let!(:project3) { create(Project, title: 'dd1', user_id: user.id) }
    let!(:member3){create(Member, project_id: project3.id, name: 'nowymember', email: 'nowy@email.com' )}
    it 'confirm membership' do
      get :confirm, id: member3.id, project_id: project3.id, confirm: true
      expect(member3.reload.confirm).to eq true
    end
  end


end