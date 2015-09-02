module DeviseTokenAuth
  class TokenValidationsController < DeviseTokenAuth::ApplicationController
    skip_before_filter :assert_is_devise_resource!, :only => [:validate_token]
    before_filter :set_user_by_token, :only => [:validate_token]

    def validate_token
      # @resource will have been set by set_user_token concern
      if @resource
        render json: @resource, adapter: :json_api
        # render json: {
        #   success: true,
        #   data: (ActiveModel::Serializer.serializer_for(@resource).new(@resource) rescue nil)
        # }
      else
        render json: {
          success: false,
          errors: ["Invalid login credentials"]
        }, status: 401
      end
    end
  end
end
