ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation, :role, :name, tasks_attributes: [:id, :_destroy, :title, :description, :time, :kind, :status, images_attributes: [:id, :image, :_destroy]]

  index do
    selectable_column
    column :name do |user|
      link_to user.name, admin_admin_user_path(user)
    end
    column :email
    column :role do |user|
      user.role.text
    end
    actions
  end

  filter :email
  filter :name
  filter :role

  form do |f|
    f.inputs "Admin Details" do
      f.input :name
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :role, as: :select, collection: AdminUser.role.options
    end
    f.actions
  end

  show :title => :name do |user|
    attributes_table do
      row :name
      row :email
      row :role do
        user.role.text
      end
    end
    panel "Задачи" do
      render('/admin/admin_user/scope', :admin_user => admin_user )
      # render('/admin/admin_user/status', :admin_user => admin_user )
      table_for(tasks) do
        column("Задача", :sortable => :id) {|task| link_to "#{task.title}", admin_task_path(task) }
        column("Тип") {|task| "#{task.kind.text}" }
        column("Время") {|task| "#{task.time}"}
        column("Начало работ") {|task| Russian::l task.from, format: :short }
        column("Завершение") {|task| Russian::l task.to, format: :short}
        column("События") {|task| render('/admin/tasks/actions', :task => task)}
      end
      if tasks.present?
        render('/admin/admin_user/graph', minimum: tasks.ordered.first.from, maximum: tasks.ordered_to.last.to, kind: Task.kind.values)
      else
        h2 {'Задач с такими параметрами не найдены!'}
      end
    end
  end

  controller do
    def show
      @task_scope = [[:all, resource.tasks.count, "Все"]]
      Task.kind.values.each { |o|
        @task_scope.push([o, resource.tasks.where(kind: o).count, o.text])
      }
      @task_status = Task.status.options.unshift ["Все", :all]
      # @tasks_status = params[:status].nil? || params[:status].to_sym == :all ? resource.tasks : resource.tasks.where(status: params[:status])
      scope = params[:scope].nil? || params[:scope] == 'all' ? Task.kind.values : params[:scope].split
      status = params[:status].nil? || params[:status] == 'all' ? Task.status.values : params[:status].split
      @tasks = resource.tasks.ordered.where('kind IN (?) AND status IN (?)', scope, status)
      super
    end
  end

end
