# encoding:utf-8
ActiveAdmin.register Client do

  permit_params :title, :description, :created_at, projects_attributes: [:id, :_destroy, :title]

  filter :title
  filter :description
  filter :created_at

  form do |f|
    f.inputs 'Основное' do
      f.input :title
      f.input :description, as: :ckeditor
      # f.input :projects, as: :check_boxes, collection: Project.all.map{|p| [p.title, p.id]}
    end
    f.actions
  end

  index do
    selectable_column
    column :title
    column :description do |client|
      raw client.description.html_safe
    end
    actions
  end

  show do |client|
    attributes_table do
      row :title
      row :description do
        raw client.description.html_safe
      end
      row :projects do
        ul do
         client.projects.each{|p| li{link_to p.title, admin_project_path(p)}}
        end
      end
      row :created_at
    end
  end

end


