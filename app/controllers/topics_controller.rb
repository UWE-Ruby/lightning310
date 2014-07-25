class TopicsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /topics
  # GET /topics.json
  def index
    @approved_topics = Topic.approved.not_completed
    @pending_topics = Topic.pending_approval.not_completed
    @completed_topics = Topic.completed
    @topic_sections = [:approved_topics,
                       :pending_topics,
                       :completed_topics]
    @headings = [
                  :student_id,
                  :title,
                  :description,
                  :proposed_date,
                  :completed_date
    ].map{|h| Topic.human_attribute_name(h)}
    @headings.push I18n.t('.actions', default: I18n.t("helpers.actions"))
    @headings.push "Admin Actions" if current_user.is_admin?
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
    @student = @topic.student
  end

  # GET /topics/new
  def new
  end

  # GET /topics/1/edit
  def edit
  end

  # POST /topics
  # POST /topics.json
  def create
    @topic.student = current_user

    respond_to do |format|
      if @topic.save
        format.html { redirect_to @topic, notice: 'Topic was successfully created.' }
        format.mobile { redirect_to @topic, notice: 'Topic was successfully created.' }
        format.json { render :show, status: :created, location: @topic }
      else
        format.html { render :new }
        format.mobile { render :new }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /topics/1
  # PATCH/PUT /topics/1.json
  def update
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to @topic, notice: 'Topic was successfully updated.' }
        format.mobile { redirect_to @topic, notice: 'Topic was successfully updated.' }
        format.json { render :show, status: :ok, location: @topic }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    respond_to do |format|
      if @topic.destroy
        format.html { redirect_to topics_url, notice: 'Topic was successfully destroyed.' }
        format.mobile{ redirect_to topics_url, notice: 'Topic was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  def approve
    return redirect_to topics_url if @topic.approve!
    redirect_to topics_url, notice: 'Problem approving topic'
  end

  def complete
    return redirect_to topics_url if @topic.complete!
    redirect_to topics_url, notice: 'Problem completing topic'
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def topic_params
      params.require(:topic).permit(:title, :description, :proposed_date)
    end
end
