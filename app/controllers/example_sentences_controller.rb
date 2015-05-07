class ExampleSentencesController < ApplicationController

  load_and_authorize_resource
  layout 'frontend'
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
    @example_sentence = ExampleSentence.find(params[:id])
    
    if request.env['HTTP_REFERER'] == article_url(@example_sentence.article)
      render layout: 'frontend'
    else
      render layout: 'admin'
    end
  end

  # POST /comments
  # POST /comments.json
  def create
    @example_sentence = ExampleSentence.new(params[:example_sentence])

    respond_to do |format|
      if @example_sentence.save
        format.html { redirect_to :back, notice: '例句添加成功' }
      else
        format.html { redirect_to :back }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    @example_sentence = ExampleSentence.find(params[:id])
    @article = @example_sentence.article
    respond_to do |format|
      if @example_sentence.update_attributes(params[:example_sentence])
        format.html { redirect_to article_path(@article), notice: '例句更新成功' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @example_sentence = ExampleSentence.find(params[:id])
    @example_sentence.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end
end
