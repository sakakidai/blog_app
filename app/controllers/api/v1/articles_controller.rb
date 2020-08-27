module Api
  module V1
    class ArticlesController < ApplicationController

      def index
        @articles = Article.with_attached_thumbnail.order(id: :desc)
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
        @article.attributes = article_params.slice(:title, :content)

        unless @article.thumbnail_url == article_params[:thumbnail][:data]
          @article.thumbnail.attach(article_params[:thumbnail])
        end

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
          :content,
          thumbnail: :data
        )
      end
    end
  end
end
