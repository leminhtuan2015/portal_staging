class Admin::CustomersController < Admin::BaseController
  include Admin::BaseHelper
  def index
    @customers = Customer.all
  end

  def new
    @customer = Customer.new
  end

  def create
    if Customer.create customer_params
      flash[:success] = t("admin.customer.create_customer_success")
      redirect_to admin_customers_path
    else
      flash[:danger] = t("admin.customer.create_customer_fail")
      render :new
    end
  end

  def edit
    @customer = Customer.find params[:id]
  end

  def update
    @customer = Customer.find params[:id]
    if @customer.update_attributes customer_params
      flash[:success] = t("admin.customer.update_customer_success")
      redirect_to admin_customers_path
    else
      flash[:danger] = t("admin.customer.update_customer_fail")
      render :edit
    end
  end

  def show
    @customer = Customer.find params[:id]
  end

  def destroy
    if Customer.find(params[:id]).destroy
      flash[:success] = t("admin.customer.destroy_customer_success")
    else
      flash[:danger] = t("admin.customer.destroy_customer_fail")
    end
    redirect_to admin_customers_path
  end

  private
  def customer_params
    params.require(:customer).permit :company, :password, :family_name, :first_name,
      :tel, :postal_code, :city, :street, :building, :siteurl,
      :birthday, :sex, :mailmagazine_accepted, :perfectural
  end
end
