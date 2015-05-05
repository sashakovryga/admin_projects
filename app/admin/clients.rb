# encoding:utf-8
ActiveAdmin.register Client do

  permit_params :title, :description, :created_at

  filter :title
  filter :description
  filter :created_at

  form do |f|
    f.inputs 'Основное' do
      f.input :title
      f.input :description, as: :ckeditor
    end
    f.actions
  end

  show do |client|
    attributes_table do
      row :title
      row :description do
        raw client.description.html_safe
      end
      row :projects do
        ul do
         client.projects.each{|p| li{p.title}}
        end
      end
      row :created_at
    end
  end

end


