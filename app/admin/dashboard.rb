ActiveAdmin.register_page "Dashboard" do

  menu  :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => "Статистика по активности" do
    panel "Проекты" do
      # @statuses = Project.select('status, COUNT(id) as cnt').group(:status).order(:status)
      projects = Project.ordered
      # unless params[:with_status].blank?
      #   @projects = @projects.with_status params[:with_status]
      # end
      minimum = Project.all.map(&:from).min
      maximum = Project.all.map(&:to).max
      render 'graph', minimum: minimum, maximum: maximum, projects: projects
    end
  end
end
