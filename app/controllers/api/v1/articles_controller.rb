module Api
  module V1
    class ArticlesController < ApplicationController

      def index
        @articles = Article.order(id: :desc)
      end

      def show
        @article = Article.find(params[:id])
      end

      def create
        @article = Article.new(article_params)

        if @article.save
          render json: @article, status: :created
        else
          render json: @article.errors, status: :unprocessable_entity
        end
      end

      def update
        @article = Article.find(params[:id])
        @article.attributes = article_params

        if @article.save
          render json: @article
        else
          render json: @article.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @article = Article.find(params[:id])
        @article.destroy
        render json: @article
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
