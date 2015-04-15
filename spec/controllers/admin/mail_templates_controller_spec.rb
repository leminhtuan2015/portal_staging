require "spec_helper"

describe Admin::MailTemplatesController do
  before(:each) {request.session = {user: admin.id}}
  let(:admin) {create :user, :as_admin}
  let!(:blog) {create :blog}

  describe "GET #index" do
    before {get :index}
    it {expect(response).to render_template :index}
    it {expect(assigns[:mail_templates]).not_to be_nil}
  end

  describe "POST #create" do
    let(:mail_template_params) {{name: "name", subject: "", text: ""}}
    it do
      expect {
        post :create, mail_template: mail_template_params
      }.to change(MailTemplate, :count).by 1
    end
    it do
      post :create, mail_template: mail_template_params
      expect(response).to redirect_to admin_mail_template_path assigns[:mail_template]
    end
    context "validate is failure" do
      before {create :mail_template, mail_template_params}
      it do 
        expect {
          post :create, mail_template: mail_template_params
        }.not_to change(MailTemplate, :count)
      end
      it do
        post :create, mail_template: mail_template_params
        expect(response).to render_template :new
      end
    end
  end

  describe "POST #update" do
    let(:new_subject) {"new subject"}
    let(:mail_template) {FactoryGirl.create :mail_template}
    before {post :update, id: mail_template.id, mail_template: {subject: new_subject}}
    it {expect(response).to redirect_to admin_mail_template_path mail_template}
    it {expect(mail_template.reload.subject).to eq new_subject}
  end

  describe "POST #destroy" do
    it do
      mail_template = FactoryGirl.create :mail_template
      expect {
        post :destroy, id: mail_template.id
      }.to change(MailTemplate, :count).by -1
    end
  end
end
