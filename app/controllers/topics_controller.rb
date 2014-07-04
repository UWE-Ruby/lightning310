class TopicsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_topic, only: [:show, :edit, :update, :destroy]

  # GET /topics
  # GET /topics.json
  def index
    @approved_topics = Topic.approved.not_completed
    @pending_topics = Topic.pending_approval.not_completed
    @completed_topics = Topic.completed
    @headings = [:student_id, :title, :description, :proposed_date, :completed_date]
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
    @student = @topic.student
  end

  # GET /topics/new
  def new
    @topic = Topic.new
  end

  # GET /topics/1/edit
  def edit
  end

  # POST /topics
  # POST /topics.json
  def create
    @topic = Topic.new(topic_params)
    @topic.student = current_user

    respond_to do |format|
      if @topic.save
        format.html { redirect_to @topic, notice: 'Topic was successfully created.' }
        format.json { render :show, status: :created, location: @topic }
      else
        format.html { render :new }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /topics/1
  # PATCH/PUT /topics/1.json
  def update
    respond_to do |format|
      if @topic.student == current_user && @topic.update(topic_params)
        format.html { redirect_to @topic, notice: 'Topic was successfully updated.' }
        format.json { render :show, status: :ok, location: @topic }
      else
        flash[:notice] = "You can not edit a topic that isn't yours!"
        format.html { render :edit }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    respond_to do |format|
      if @topic.student == current_user
        @topic.destroy
        format.html { redirect_to topics_url, notice: 'Topic was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { redirect_to topics_url, notice: "You can not destroy a topic that isn't yours!" }
        format.json { render json: "You can not destroy a topic that isn't yours!", status: :unprocessable_entity}
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def topic_params
      params.require(:topic).permit(:title, :description, :proposed_date)
    end
end
