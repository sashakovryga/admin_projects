# encoding:utf-8
ActiveAdmin.register Project do
  # menu :parent => 'Проект'

  permit_params :title, :description, :from, :to, :created_at, :from_date, :from_time_hour, :from_time_minute, :to_date, :to_time_hour, :client_id, :to_time_minute, :step, :status,
                tasks_attributes: [:id, :_destroy, :title, :description, :time, :kind, :status, images_attributes: [:id, :image, :_destroy]],
                payments_attributes: [:id, :_destroy, :comment, :price]

  filter :description
  filter :from
  filter :to_date
  filter :created_at

  form do |f|
    f.inputs 'Основное' do
      f.input :title
      f.input :description, as: :ckeditor
      f.input :from, as: :just_datetime_picker
      f.input :to, as: :just_datetime_picker
      f.input :status, as: :select, collection: Project.status.options
      # f.input :client, as: :select, collection: Client.all.map{|c| [c.title, c.id]}
      # f.inputs 'Задачи' do
      #   f.has_many :tasks do |a|
      #     a.input :_destroy, as: :boolean
      #     a.input :title
      #     a.input :description, as: :ckeditor
      #     a.input :time
      #     a.input :kind, as: :select, collection: Task.kind.options
      #     a.input :status, as: :select, collection: Task.status.options
      #     a.has_many :images do |p|
      #       p.input :image, :as => :file, :hint => p.object.image.nil? ? a.template.content_tag(:span, "no image") : a.template.image_tag(p.object.image.thumb('100x100').url)
      #       p.input :_destroy, :as => :boolean if !p.object.image.nil?
      #     end
      #   end
      # end
    end
    f.actions
  end

  index do
    selectable_column
    column :title
    column :description do |project|
      raw project.description.html_safe
    end
    column :created_at
    actions
  end

  show :title => :title do |project|
    panel "Задачи" do
      render('/admin/tasks/scope', :project => project )
      # render('/admin/tasks/status', :project => project )
      table_for(tasks) do
        column("Задача", :sortable => :id) {|task| link_to "#{task.title}", admin_task_path(task) }
        column("Тип") {|task| "#{task.kind}" }
        column("Время") {|task| "#{task.time}"}
        column("Начало работ") {|task| Russian::l task.from, format: :short }
        column("Завершение") {|task| Russian::l task.to, format: :short}
        column("События") {|task| render('/admin/tasks/actions', :task => task)}
      end
      render('/admin/projects/graph', minimum: project.from, maximum: project.to, kind: Task.kind.values)
    end
    if project.payments.present?
      panel 'Платежки' do
        table_for(project.payments) do
          column("Описание", :sortable => :id) {|payment| link_to "#{payment.comment}.".html_safe, admin_payment_path(payment) }
          column("Сумма") {|payment| "#{payment.price} $" }
          if can? :create, project.payments
            column("События") {|payment| render('/admin/payments/actions', :payment => payment)}
          end
        end
      end
    end
  end

  sidebar "Общая информация", :only => :show do
    attributes_table_for project do
      row("Описание") { project.description.html_safe }
      row("Общее время") { [project.tasks.map(&:time).sum, 'часов'].join(' ') }
      row("Бюджет") { [project.payments.map(&:price).sum, '$'].join(' ') }
    end
    div class: 'sidebar' do
      span do
        link_to 'Создать задачу', new_admin_task_path(project: project), class: 'btn btn-primary'
      end
      if can? :create, project.payments
        span do
          link_to 'Добавить платежку', new_admin_payment_path(project: project), class: 'btn btn-primary'
        end
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
      # @tasks_statuses = params[:status].nil? || params[:status].to_sym == :all ? resource.tasks : resource.tasks.where(status: params[:status])
      scope = params[:scope].nil? || params[:scope] == 'all' ? Task.kind.values : params[:scope].split
      status = params[:status].nil? || params[:status] == 'all' ? Task.status.values : params[:status].split
      @tasks = resource.tasks.ordered.where('kind IN (?) AND status IN (?)', scope, status)
      super
    end
  end

end


