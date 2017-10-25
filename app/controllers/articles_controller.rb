class ArticlesController < ApplicationController
  #-Article controller follows ruby basic CRUD principle
  #-Index - display all articles on page
  #-Show - show a particular article
  #-New - load article form page
  #-Edit - modify an article
  #-Create - create a new article
  #-Destroy - delete an article

  #-simple authentication on all pages except index and show page
  #-login with username:test and password:root
  http_basic_authenticate_with name: "test", password: "root", except: [:index, :dhow]

  #-display all articles
  def index
    @articles = Article.all
  end

  #-display an article by passing its an id
  def show
    @article = Article.find(params[:id])
  end

  #-load the article page to create new article
  def new
    @article = Article.new
  end

  #-edit an article by passing an id
  def edit
    @article = Article.find(params[:id])
  end

  def create
    #render plain: params[:article].inspect

    #-create a new article and insert its data into Article model
    #-@param article_params is the private method for which retrieved the post fields
    @article = Article.new(article_params)

    #-boolean function save checks to see if the data was saved or not
    #-if true it redirects to article show
    if @article.save
       redirect_to @article
     else
       render 'new'
     end
  end

  #-update an article
  def update
    @article = Article.find(params[:id])

    #-try to update if sucessfull else return back to the same page
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  #delete an article and redirect backt to index
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end


  #by creating a private method - we intend to use strong param
  #so that it ensures that it only accepts these fields and cant
  #also be called outside of this controller
  private
    def article_params
      params.require(:article).permit(:title, :text)
    end
end
