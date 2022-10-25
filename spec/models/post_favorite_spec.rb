require "rails_helper"

RSpec.describe "Favoriteモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    subject { post_favorite.valid? }

    let!(:other_post_favorite) { create(:post_favorite) }
    let(:post_favorite) { build(:post_favorite) }

    context "1ユーザー 1投稿 1いいね" do
      it "あるユーザーが同じ投稿にいいね出来ないこと" do
        post_favorite.user = other_post_favorite.user
        post_favorite.post = other_post_favorite.post
        is_expected.to eq false
      end
    end
  end

  describe "アソシエーションのテスト" do
    context "Userモデルとの関係" do
      it "N:1となっている" do
        expect(PostFavorite.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context "Postモデルとの関係" do
      it "N:1となっている" do
        expect(PostFavorite.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end
  end
end
