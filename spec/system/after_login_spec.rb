require 'rails_helper'

describe '投稿のテスト' do
  describe "新規投稿画面(new_post_path)のテスト" do
    before do
      @post = FactoryBot.create(:post)
      @user = FactoryBot.create(:user)
      sign_in @user
      visit new_post_path
    end
    
    context '表示の確認' do
      it 'new_post_pathが"/posts/new"であるか' do
        expect(current_path).to eq('/posts/new')
      end
      it '新規投稿ボタンが表示されているか' do
        expect(page).to have_button '新規投稿'
      end
    end
    
    context '投稿処理のテスト' do
      it '投稿後のリダイレクト先は正しいか' do
        fill_in 'post[item_name]', with: Faker::Lorem.characters(number:10)
        fill_in 'post[review_title]', with: Faker::Lorem.characters(number:10)
        fill_in 'post[review_body]', with: Faker::Lorem.characters(number:30)
        click_button '新規投稿'
        expect(page).to have_current_path posts_path
      end
    end
  end
  
end