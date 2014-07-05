require 'spec_helper'

describe UsersController do

  describe "GET#index" do
    before(:each) do
      @users = stub_index(User)
    end
  end
  before do
    sign_in user
  end

  let(:user) { create(User) }
  describe 'PUT#update_password' do
      it ' update password' do
      put :update_password, id: user.id, user:{custom_password: 'aaa',password_conf: 'aaa'}
      expect(response.status).to eq 302
      end
    it 'validate when custom_password and confirmation_password are different' do
      put :update_password, id: user.id, user:{custom_password: 'aaa',password_conf: 'aaaa'}
      expect(response.status).to eq 422
    end
  end
end