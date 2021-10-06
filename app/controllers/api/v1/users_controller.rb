module Api
  module V1
    class UsersController < BaseController

      def signup
        exist_user = User.find_by(email: params[:user][:email])
        if exist_user
          render json: { message: "User already exist with this email.", error: "User exists", status: 409} and return
        else
          user = User.new(user_params)
          if user.save
             token = JsonWebToken.encode(user_id: @user.id)
             user.update(auth_token: token)
             render json: {message: "Account Created Successfully.Thanks.", user: UserSerializer.new(user, root: false), status: 200} and return
          end
        end
      end

      def login
        @user = User.find_by(email:params[:user][:email].downcase)
          if @user
            if @user.valid_password?(params[:user][:password])
              token = JsonWebToken.encode(user_id: @user.id)
              @user.update_column('auth_token', token)
              render json: {message: "User Login Successfully.", user: UserSerializer.new(@user, root: false), status: 201} and return
            else
              render json: {message: "Wrong password. Could not authenticate!", error: "Wrong Password", status: 401} and return
            end
          else
            render json: {message: "User does not exist with this mail.", error: 'User does not exist.', status: 404 } and return
          end
        end
      end

      private

      def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password)
      end

    end
  end
end
