# encoding:utf-8
ActiveAdmin.register Project do
  menu :parent => 'Проект'

  permit_params :title, :description, :from, :to, :created_at, :from_date, :from_time_hour, :from_time_minute, :to_date, :to_time_hour, :to_time_minute, :step,
                tasks_attributes: [:id, :_destroy, :title, :description, :time, :kind, :status, images_attributes: [:id, :image, :_destroy]]

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
      f.inputs 'Задачи' do
        f.has_many :tasks do |a|
          a.input :_destroy, as: :boolean
          a.input :title
          a.input :description, as: :ckeditor
          a.input :time
          a.input :kind, as: :select, collection: Task.kind.options
          a.input :status, as: :select, collection: Task.status.options
          a.has_many :images do |p|
            p.input :image, :as => :file, :hint => p.object.image.nil? ? a.template.content_tag(:span, "no image") : a.template.image_tag(p.object.image.thumb('100x100').url)
            p.input :_destroy, :as => :boolean if !p.object.image.nil?
          end
        end
      end
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

  # show do |project|
  #   attributes_table do
  #     row :title
  #     row :description do |project|
  #       raw project.description.html_safe
  #     end
  #     row :from
  #     row :to
  #     row :tasks do
  #       ul do
  #         project.tasks.each do |task|
  #           li do
  #             div do
  #               # task.description.html_safe
  #               task.kind
  #             end
  #           end
  #         end
  #       end
  #     end
  #     row :created_at
  #   end
  # end

  show :title => :title do |project|
    panel "Задачи" do
      render('/admin/tasks/scope', :project => project )
      table_for(tasks) do
        column("Задача", :sortable => :id) {|task| link_to "#{task.title}", admin_task_path(task) }
        column("Тип") {|task| "#{task.kind}" }
        column("Время") {|task| "#{task.time}"}
        column("События") {|task| render('/admin/tasks/actions', :task => task)}
      end
      render('/admin/projects/graph', minimum: project.from, maximum: project.to, tasks: project.tasks)
    end
  end

  sidebar "Общая информация", :only => :show do
    attributes_table_for project do
      row("Общее время") { project.to }
    end
  end

  controller do
    def show
      @task_scope = [[:all, Task.all.count, "Все"]]
      Task.kind.values.each { |o|
        @task_scope.push([o, Task.where(kind: o).count, o.text])
      }
      @tasks = params[:scope].nil? || params[:scope].to_sym == :all ? Task.all : Task.where(kind: params[:scope])
      super
    end
  end

end


