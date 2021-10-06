module Api
  module V1
    class PostsController < BaseController
      before_action :authorize_request

      def index
        posts = @current_user.posts
        render json: { status: 200, posts: ActiveModelSerializers::SerializableResource.new(posts, each_serializer: PostSerializer)}
      end

      def create
        post = @current_user.posts.create(post_params)
        render json: { message: "Post Created Successfully.", status: 200 } and return
      end

      def show
      end

      def update
      end

      def destroy
      end

      private

      def get_post
        @post = @current_user.posts.find_by(id: params[:id])
      end

      def post_params
        params.require(:post).permit(:question)
      end

    end
  end
end
