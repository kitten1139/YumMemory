require 'rails_helper'

RSpec.describe 'Commentモデルのテスト', type: :model do
  before do
    user = FactoryBot.create(:user)
    post = FactoryBot.create(:post)
    @comment = FactoryBot.build(:post_comment, user_id: user.id, post_id: post.id)
  end

  describe 'コメント機能' do
    context 'コメントを保存できる場合' do
      it "コメント文を入力済みであれば保存できる" do
        expect(@comment).to be_valid
      end
    end

    context 'コメントを保存できない場合' do
      it "コメントが空では投稿できない" do
        @comment.body = ''
        @comment.valid?
        expect(@comment.errors.full_messages).to include "Bodyを入力してください"
      end

      it "ユーザーがログインしていなければコメントできない" do
        @comment.user_id = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include "Userを入力してください"
      end

      it "投稿したものがなければコメントできない" do
        @comment.post_id = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include "Postを入力してください"
      end
    end
  end
end