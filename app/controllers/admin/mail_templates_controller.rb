class Admin::MailTemplatesController < Admin::BaseController
  layout "administration"
  cache_sweeper :blog_sweeper
  before_filter :find_mail_templates, except: [:index, :new]

  def index
    @mail_templates = MailTemplate.page(params[:page]).per this_blog.limit_article_display
  end

  def create
    @mail_template = MailTemplate.new mail_template_params
    if @mail_template.save
      flash[:success] = I18n.t "notice.mail_template.successfully_created"
      redirect_to admin_mail_template_path @mail_template
    else
      flash[:error] = I18n.t "notice.mail_template.create_failed"
      render :new
    end
  end

  def update
    if @mail_template.update_attributes mail_template_params
      flash[:success] = I18n.t "notice.mail_template.successfully_updated"
      redirect_to admin_mail_template_path @mail_template
    else
      flash[:error] = I18n.t "notice.mail_template.update_failed"
      render :edit
    end
  end

  def destroy
    if @mail_template.destroy
      flash[:notice] = I18n.t "notice.mail_template.successfully_destroy"
    else
      flash[:error] = I18n.t "notice.mail_template.destroy_false"
    end
    redirect_to admin_mail_templates_path
  end

  private
  def find_mail_templates
    @mail_template = MailTemplate.find params[:id]
  end

  def mail_template_params
    params.require(:mail_template).permit :name, :subject, :text
  end
end
