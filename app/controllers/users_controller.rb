class UsersController < ApplicationController

  # GET /user/1/edit
  def edit
  end

  # PATCH/PUT /user/1
  def update
  end

  private

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.permit(:user_id, hashtags: [])
    end
end
