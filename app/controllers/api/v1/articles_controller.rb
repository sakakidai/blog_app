module Api
  module V1
    class ArticlesController < ApplicationController
      # GET /articles
      def index
        @articles = Article.order(id: :desc)
      end
    end
  end
end
