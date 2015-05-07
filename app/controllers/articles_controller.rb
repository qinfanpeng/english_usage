class ArticlesController < ApplicationController

  before_filter :get_article, only: [:update, :edit, :show]

  layout 'frontend'

  respond_to :html, :json

  def index
    @articles = Article.published.includes(:columns)
      .paginate(:page => params[:page], per_page: 8)

    respond_to do |format|
      format.html
      format.json { render json: @articles }
    end
  end

  def new
    @article = Article.new
    respond_with @article
  end

  def create
    @article = Article.new(params[:article])
    respond_with(@article) do |format|
      if @article.save
        flash[:notice] = t('article.flash.create.success')
        format.html { redirect_to @article }
      else
        flash[:error] = t('article.flash.create.error')
      end
    end
  end

  def update
    respond_with(@article) do |format|
      if @article.update_attributes(params[:article])
        flash[:notice] = t('article.flash.update.success')
        format.html { redirect_to  @article }
      else
        flash[:error] = t('article.flash.update.error')
      end
    end
  end

  def show
    @article = Article.find(params[:id])

    @comments = @article.comments.all
    @example_sentences = @article.example_sentences.all

    @comment = @article.comments.build
    @example_sentence = @article.example_sentences.build

    respond_to do |format|
      format.html
      format.json { render json: @article }
    end
  end

  def belong_to_column
    @column = Column.find(params[:id])
    @articles = @column.articles
      .published
      .paginate(:page => params[:page], per_page: 8)
    render :index
  end

  def search
    search = Article.search do
      fulltext params[:query] do
        boost_fields :title => 2.0
      end
      order_by :created_at, :desc
      paginate page: params[:page]
    end
    @articles = search.results
    render :index
  end

end
