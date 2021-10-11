module Api
  module V1
    class VotesController < BaseController
      before_action :authorize_request
      before_action :get_vote, only: [:show, :update, :destroy]
      before_action :validate_params, only: [:create, :update]

      def create
        comment = Comment.find_by(id: params[:id].to_i) if params[:id].present?
        vote = comment.votes.create(is_up: params[:vote_up], is_down: params[:vote_down], user_id: @current_user.id) if comment.present?
        render json: { message: "vote added Successfully.", status: 200 } and return
      end

      def show
        render json: {message: "Vote Details.", comment: VoteSerializer.new(@vote, root: false), status: 200} and return
      end

      def update
        @vote.update(is_up: params[:vote_up], is_down: params[:vote_down], user_id: @current_user.id)
        render json: {message: "Vote update Successfully.", vote: VoteSerializer.new(@vote, root: false), status: 200} and return
      end

      def destroy
        @vote.destroy
        render json: {message: "vote removed Successfully.", status: 200}
      end

      private

      def validate_params
        if params[:vote_up] && params[:vote_down]
          render json: { error: "vote up and down simultaneously not allowed", status: 400} and return
        end
      end

      def get_vote
        @vote = @current_user.votes.find_by(id: params[:id])
        unless @vote
          render json: { error: "Vote can't find", status: 400}
        end
      end

    end
  end
end
