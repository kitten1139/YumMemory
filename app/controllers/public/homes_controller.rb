class Public::HomesController < ApplicationController

  def top
    @post = Post.all.order("created_at DESC").first
  end

  def about
  end

end
