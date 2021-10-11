module Api
  module V1
    class CommentsController < BaseController
      before_action :authorize_request
      before_action :get_comment, only: [:show, :update, :destroy]

      def index
        comments = @current_user.comments
        render json: { status: 200, comments: ActiveModelSerializers::SerializableResource.new(comments, each_serializer: CommentSerializer)}
      end

      def create
        comment = @current_user.comments.new(comment_params)
        if comment.save
          post = Post.find_by(id: params[:id]) if params[:id].present?
          comment.update(post_id: post&.id) if post.present?
          render json: { message: "comment added Successfully.", status: 200 }
        else
          render json: { error: comment.errors.full_messages.to_sentence, status: 400 }
        end
      end

      def show
        render json: {message: "Comment Details.", comment: CommentSerializer.new(@comment, root: false), status: 200}
      end

      def update
        if @comment.update(comment_params)
          render json: {message: "Comment updated Successfully.", comment: CommentSerializer.new(@comment, root: false), status: 200}
        else
          render json: { error: @comment.errors.full_messages.to_sentence, status: 400 }
        end
      end

      def destroy
        @comment.destroy
        render json: {message: "Comment Deleted Successfully.", status: 200} and return
      end

      private

      def get_comment
        @comment = @current_user.comments.find_by(id: params[:id])
        unless @comment
          render json: { error: "Comment can't find", status: 400}
        end
      end

      def comment_params
        params.require(:comment).permit(:comment_info)
      end

    end
  end
end
