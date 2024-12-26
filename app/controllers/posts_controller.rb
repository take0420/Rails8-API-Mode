module Api
  module V1
    class PostsController < ApplicationController
      def index
        posts = Post.order(created_at: :desc)
        render json: { status: "Success", message: "Loaded posts", data: posts }
      end

      def show
        @post = Post.find(params[:id])

        render json: { status: "Success", message: "Loaded the post", data: @post }
      end

      def create
        post = Post.new(post_params)

        if post.save
          render json: { status: "Success", data: post }
        else
          render json: { status: "Error", data: post.errors }
        end
      end

      def update
        @post = Post.find(params[:id])

        if @post.update(post_params)
          render json: { status: "Success", message: "Updated the post", data: @post }
        else
          render json: { status: "Error", message: "Not updated", data: @post.errors }
        end
      end

      def destroy
        @post = Post.find(params[:id])

        @post.destroy
        render json: { status: "Success", message: "Deleted the post", data: @post }
      end

      private

      def post_params
        params.require(:post).permit(:title)
      end
    end
  end
end
