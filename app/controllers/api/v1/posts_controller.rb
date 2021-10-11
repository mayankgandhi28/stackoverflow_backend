module Api
  module V1
    class PostsController < BaseController
      before_action :authorize_request
      before_action :get_post, only: [:show, :update, :destroy]

      def index
        posts = @current_user.posts
        render json: { status: 200, posts: ActiveModelSerializers::SerializableResource.new(posts, each_serializer: PostSerializer)}
      end

      def create
        post = @current_user.posts.new(post_params)
        if post.save
          render json: { message: "Post Created Successfully.", status: 200 }
        else
          render json: { error: post.errors.full_messages.to_sentence, status: 400 }
        end
      end

      def show
        render json: {message: "Post Details.", post: PostSerializer.new(@post, root: false), status: 200}
      end

      def update
        if @post.update(post_params)
          render json: {message: "Post updated Successfully.", post: PostSerializer.new(@post, root: false), status: 200}
        else
          render json: { error: @post.errors.full_messages.to_sentence, status: 400 }
        end
      end

      def destroy
        @post.destroy
        render json: {message: "Post Deleted Successfully.", status: 200}
      end

      private

      def get_post
        @post = @current_user.posts.find_by(id: params[:id])
        unless @post
          render json: { error: "Post can't find", status: 400}
        end
      end

      def post_params
        params.require(:post).permit(:question)
      end

    end
  end
end
