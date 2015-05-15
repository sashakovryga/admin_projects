# encoding:utf-8
ActiveAdmin.register CommentTask do
  menu false
  actions :all

  permit_params :comment, :time, :status, :user, :task_id, :task

  form do |f|
    f.inputs 'Основное' do
      f.input :comment
      f.input :time
      f.input :status, as: :select, collection: CommentTask.status.options
      f.input :user, as: :select, collection: AdminUser.all.map {|u| [u.name, u.id]}
      # if params[:project]
      #   f.input :project_id, as: :hidden, :input_html => { :value => params[:project] }
      # else
      #   f.input :project_id, as: :select, collection: Project.all.map{|e| [e.title, e.id]}
      # end
    end
    f.actions
  end

  controller do
    def create
      create! do |format|
        format.html { redirect_to admin_task_path(@comment_task.task) }
      end
    end
  end

end


