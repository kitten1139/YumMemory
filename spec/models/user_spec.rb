require "rails_helper"

RSpec.describe "Userモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    subject { user.valid? }

    let(:user) { build(:user) }

    context "nameカラム" do
      it "空欄でないこと" do
        user.nickname = ""
        is_expected.to eq false
      end
    end
  end
end
