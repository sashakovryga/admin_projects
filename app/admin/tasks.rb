# encoding:utf-8
ActiveAdmin.register Task do
  menu false

  permit_params :title, :description, :time, :created_at, :kind, :status, :project, :from_date, :from_time_hour,
                :from_time_minute, :from, :to_date, :to_time_hour, :to_time_minute, :to

  filter :description
  filter :from
  filter :to_date
  filter :created_at

  form do |f|
    f.inputs 'Основное' do
      f.input :title
      f.input :description, as: :ckeditor
      f.input :time
      f.input :from, as: :just_datetime_picker
      f.input :to, as: :just_datetime_picker
      f.input :kind, as: :select, collection: Task.kind.options
      f.input :status, as: :select, collection: Task.status.options
    end
    f.actions
  end

  show do |task|
    attributes_table do
      row :title
      row :description do
        raw task.description.html_safe
      end
      row :time
      row :kind
      row :status
      row :from
      row :to
      row :created_at
    end
  end

  sidebar "Проект", :only => [:show, :edit] do
    attributes_table_for task do
      row(task.project.title) { link_to 'Вернуться к проекту', admin_project_path(task.project) }
    end
  end

end


