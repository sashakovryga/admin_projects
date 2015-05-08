ActiveAdmin.register_page "Dashboard" do

  menu  :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => "Статистика по активности" do
    panel "Проекты" do
      client_scope = [[:all, Project.ordered.count, "Все"]]
      Client.all.each { |o|
        client_scope.push([o.title, o.projects.count, o.title])
      }
      project_status = Project.status.options.unshift ["Все", :all]
      status = params[:status].nil? || params[:status] == 'all' ? Project.status.values : params[:status].split
      client = params[:client].nil? || params[:client] == 'all' ? Client.all.to_a : Client.find_by_title(params[:client].split)
      projects = Project.ordered.where('status IN (?) AND client_id IN (?)', status, client)
      minimum = projects.map(&:from).min
      maximum = projects.map(&:to).max
      render 'scope', client_scope: client_scope, project_status: project_status
      render 'graph', minimum: minimum, maximum: maximum, projects: projects
    end
  end

end
