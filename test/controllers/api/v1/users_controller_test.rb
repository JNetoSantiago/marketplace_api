module Api
  module V1
    class UsersControllerTest < ActionDispatch::IntegrationTest
      setup do
        host! 'localhost:3000'
        @user = users(:one)
      end

      test "should show user" do
        get api_v1_user_url(@user), as: :json
        assert_response :success

        json_response = JSON.parse(self.response.body)
        assert_equal @user.email, json_response['email']
      end

      test "should create user" do
        assert_difference "User.count" do
          post api_v1_users_url, 
          params: { user: { email: 'so_and_so@email.com', password: '123456' } },
          as: :json
        end

        assert_response :created
      end

      test "should not create when invalid params are sent" do
        post api_v1_users_url,
        params: { user: { email: 'invalid', password: '123456' } },
        as: :json

        assert_response :unprocessable_entity
      end

      test "should update user" do
        patch api_v1_user_url(@user),
        headers: { Authorization: JsonWebToken.encode(user_id: @user.id) },
        params: { user: { email: 'new@email.com', password: '123456' } },
        as: :json

        assert_response :success
      end

      test "should forbid update user" do
        patch api_v1_user_url(@user),
        params: { user: { email: 'new@email.com', password: '123456' } },
        as: :json

        assert_response :forbidden
      end

      test "should not update when invalid params are sent" do
        patch api_v1_user_url(@user),
        headers: { Authorization: JsonWebToken.encode(user_id: @user.id) },
        params: { user: { email: 'invalid', password: '123456' } },
        as: :json
        
        assert_response :unprocessable_entity
      end

      test "should destroy user" do
        assert_difference "User.count", -1 do
          delete api_v1_user_url(@user), 
          headers: { Authorization: JsonWebToken.encode(user_id: @user.id) },
          as: :json
        end
        assert_response :no_content
      end

      test "should forbid destroy user" do
        assert_no_difference "User.count" do
          delete api_v1_user_url(@user), as: :json
        end
        assert_response :forbidden
      end
    end
  end
end