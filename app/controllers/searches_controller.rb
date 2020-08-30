class SearchesController < ApplicationController
	def index
		@book = Book.new
		@user = current_user
		method = params[:name]
		word = params[:search]
		@users = User.search(method,word)
	end
end
