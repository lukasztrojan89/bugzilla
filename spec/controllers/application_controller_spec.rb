require 'spec_helper'

describe ApplicationController do
render_views
  controller do
    def after_sign_in_path_for(resource)
      super resource
    end
  end

  before :each do
    sign_in user
  end
let!(:user){create(User)}

  describe 'After sigin-in' do
    it 'redirects to the /jobs page' do
      controller.after_sign_in_path_for(user).should == projects_path
    end
  end
end