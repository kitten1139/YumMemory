class Public::HomesController < ApplicationController

  def top
    #公開投稿の最新の投稿を取得
    @post = Post.privacy.all.order("created_at DESC").first
  end

  def about
  end

end
