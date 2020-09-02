module Api
  module V1
    class ArticlesController < ApplicationController

      def index
        @articles = Article.with_attached_thumbnail.order(id: :desc).page(params[:page]).per(10)
      end

      def show
        @article = Article.find(params[:id])
      end

      def create
        @article = Article.new(article_params)
        @article.thumbnail.attach(article_thumbnail_params) if article_thumbnail_params[:data].present?

        if @article.save
          render json: @article, status: :created
        else
          render json: @article.errors, status: :unprocessable_entity
        end
      end

      def update
        @article = Article.find(params[:id])
        @article.attributes = article_params.slice(:title, :description)

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

      def article_require_params
        params.require(:article).permit(
          :title,
          :description,
          thumbnail: :data,
          sections_attributes: [:id, :title, :description, :_destroy]
        )
      end

      def article_params
        article_require_params.except(:thumbnail)
      end

      def article_thumbnail_params
        article_require_params[:thumbnail]
      end
    end
  end
end
