ActiveAdmin.register_page "Dashboard" do

  menu  :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => "Статистика по активности" do
    panel "Проекты" do
      client_scope = [[:all, Project.ordered.count, "Все"]]
      Client.all.each { |o|
        client_scope.push([o.title, o.projects.count, o.title])
      }
      projects = params[:scope].nil? || params[:scope].to_sym == :all ? Project.ordered : Project.ordered.where(client: Client.find_by_title(params[:scope]))
      minimum = projects.map(&:from).min
      maximum = projects.map(&:to).max
      render 'scope', client_scope: client_scope
      render 'graph', minimum: minimum, maximum: maximum, projects: projects
    end
  end

  controller do
    def show
      @project_scope = [[:all, resource.projects.count, "Все"]]
      Task.kind.values.each { |o|
        @task_scope.push([o, resource.tasks.where(kind: o).count, o.text])
      }
      @tasks = params[:scope].nil? || params[:scope].to_sym == :all ? resource.tasks : resource.tasks.where(kind: params[:scope])
      super
    end
  end
end
