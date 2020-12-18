# frozen_string_literal: true

# BigBlueButton open source conferencing system - http://www.bigbluebutton.org/.

# Copyright (c) 2018 BigBlueButton Inc. and by respective authors (see below).

# This program is free software; you can redistribute it and/or modify it under the
# terms of the GNU Lesser General Public License as published by the Free Software
# Foundation; either version 3.0 of the License, or (at your option) any later
# version.

# BigBlueButton is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
# PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

# You should have received a copy of the GNU Lesser General Public License along
# with BigBlueButton; if not, see <http://www.gnu.org/licenses/>.

class SessionsController < ApplicationController
  def new
    redirect_to(admin_users_path) if session[:user_id]
  end

  def create
    user = User.find_by_username(params[:username])
    if user&.authenticate(params[:password]) && user&.admin
      session[:user_id] = user.id
      redirect_to(admin_users_path)
    else
      flash.now[:alert] = 'Username or password is invalid'
      redirect_to(login_path, notice: 'Incorrect Username or Password')
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to(root_path)
  end
end
