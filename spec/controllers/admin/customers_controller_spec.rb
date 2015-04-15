require "spec_helper"
RSpec.describe Admin::CustomersController do
  let(:customer) {mock_model Customer}
  before {request.session = {user: admin.id}}
  let(:admin) {create :user, :as_admin}
  let!(:blog) {create :blog}

  describe "GET index" do
    before do
      customer = FactoryGirl.create :customer
      get :index
    end
    it {expect(response).to render_template :index}
    it {expect(response.status).to eq 200}
    it {expect(assigns :customers).should eq [customer]}
  end

  describe "POST create" do
    let(:customer_params) {{company: "company_name"}}
    context "when the customer saves successfully" do
      it {expect{post :create, customer: customer_params}.to change(Customer, :count).by 1}
    end

    context "when the customer saves failure" do
      before do
        Customer.stub(:new).and_return customer
        customer.stub(:save).and_return false
      end
      it {expect{post :create, customer: customer_params}.not_to change(Customer, :count)}
    end
  end

  describe "POST update" do
    let(:customer) {FactoryGirl.create :customer}
    
    context "when the customer update successfully" do
      before {post :update, id: customer.id, customer: {company: "New_name"}}
      it {expect(response).to redirect_to admin_customers_path}
      it {expect(flash[:success]).to eq I18n.t("admin.customer.update_customer_success")}
      it {expect(customer.reload.company).to eq "New_name"}
    end

    context "when the customer update failure" do
      let(:invalid_customer_params) {{text: nil, family: nil}}
      before do
        Customer.stub(:update_attributes).and_return false
        post :update, id: customer.id, customer: invalid_customer_params
      end
      it {expect(response).should render_template :edit}
    end

  end

  describe "DELETE Destory" do
    before {customer = FactoryGirl.create :customer}
    it {expect{delete :destroy, id: customer.id}.to change(Customer, :count).by -1}
  end
end


