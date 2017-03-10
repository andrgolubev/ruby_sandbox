module ArticlesHelper
  def article_params #strong parameters for article hash
    params.require(:article).permit(:title, :body)
  end
end
