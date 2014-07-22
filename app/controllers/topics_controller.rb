class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy]
  before_action :validate_user_group_member, except: [:index, :show]
  before_action :authenticate_person!

  def index
    @topics = Topic.all
  end

  def show
  end

  def new
    @topic = Topic.new
  end

  def edit
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.person = current_person

    if @topic.save
      redirect_to @topic.group, notice: 'Topic was successfully created. If you bring cake, people
      will be more willing to discuss it with you.'
    else
      render action: 'new'
    end
  end

  def update
    if @topic.update(topic_params)
      redirect_to @topic.group, notice: 'Topic was successfully updated. All efforts, nomatter how small, deserve cake.'
    else
      render action: 'edit'
    end
  end

  def destroy
    group = @topic.group
    @topic.destroy
    redirect_to group_path(group)
  end

  private
  def set_topic
    @topic = Topic.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(:body, :group_id, :full_name)
  end

  def validate_user_group_member
    group = Group.find params[:group_id]
    unless group.editable_by? current_person
      redirect_to group_path(params[:group_id]),
                  notice: 'You are not allowed to do that'
    end
  end
end
