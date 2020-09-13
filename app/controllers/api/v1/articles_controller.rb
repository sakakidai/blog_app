module Api
  module V1
    class ArticlesController < ApplicationController
      before_action :modify_params, only: %i[create update]

      def index
        @articles = Article.with_attached_thumbnail.order(id: :desc).page(params[:page]).per(10)
      end

      def edit
        @article = Article.find(params[:id])
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
        params.require(:article).permit(
          :title,
          :description,
          :thumbnail_type,
          thumbnail: :data,
          youtube_attributes: [:video_id, :_destroy],
          sections_attributes: [:id, :title, :description, :_destroy, photo: :data]
        )
      end

      def modify_params
        params[:article].delete(:thumbnail) if params[:article][:thumbnail][:data].blank?
        params[:article][:sections_attributes].each { |section| section.delete(:photo) if section['photo']['data'].nil? }
      end
    end
  end
end
