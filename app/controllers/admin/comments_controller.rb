class Admin::CommentsController < ApplicationController

  load_and_authorize_resource
  layout 'admin'
  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.json
  def new
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
    
    if request.env['HTTP_REFERER'] == article_url(@comment.article)
      render layout: 'frontend'
    else
      render layout: 'admin'
    end
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(params[:comment])

    respond_to do |format|
      if @comment.save
        format.html { redirect_to :back, notice: '释义添加成功' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { redirect_to :back }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    @comment = Comment.find(params[:id])
    @article = @comment.article
    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        # if request.env['HTTP_REFERER'] == article_url(@comment.article)
        #   format.html { redirect_to article_path(@article), notice: 'Comment was successfully updated.' }
        # else
        #   format.html { redirect_to admin_article_path(@article), notice: 'Comment was successfully updated.' }
        # end
        format.html { redirect_to article_path(@article), notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end
end
