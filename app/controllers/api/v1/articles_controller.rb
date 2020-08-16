module Api
  module V1
    class ArticlesController < ApplicationController

      # GET /articles
      def index
        @articles = Article.order(id: :desc)
      end

      def create
        @article = Article.new(article_params)

        if @article.save
          render json: @article, status: :created
        else
          render json: @article.errors, status: :unprocessable_entity
        end
      end

      private

      def article_params
        params.fetch(:article, {}).permit(
          :title,
          :content
        )
      end
    end
  end
end
