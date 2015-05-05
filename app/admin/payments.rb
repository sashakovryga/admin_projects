# encoding:utf-8
ActiveAdmin.register Payment do
  menu false

  permit_params :price, :comment, :project_id

  filter :comment
  filter :created_at

  form do |f|
    f.inputs 'Основное' do
      f.input :price
      f.input :comment, as: :ckeditor
      if params[:project]
        f.input :project_id, as: :hidden, :input_html => { :value => params[:project] }
      else
        f.input :project_id, as: :select, collection: Project.all.map{|e| [e.title, e.id]}
      end
    end
    f.actions
  end

  show do |payment|
    attributes_table do
      row :price
      row :comment do
        raw payment.comment.html_safe
      end
      row :created_at
    end
  end

  sidebar "Проект", :only => [:show, :edit] do
    link_to 'Вернуться к проекту', admin_project_path(payment.project), class: 'btn btn-primary'
  end

  controller do
    def update
      update! do |format|
        format.html { redirect_to admin_project_path(@payment.project) }
      end
    end

    def create
      create! do |format|
        format.html { redirect_to admin_project_path(@payment.project) }
      end
    end

    def destroy
      destroy! do |format|
        format.html { redirect_to admin_project_path(@payment.project) }
      end
    end
  end

end


