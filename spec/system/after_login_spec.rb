require 'rails_helper'

describe '[STEP2] ユーザログイン後のテスト' do
  let(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:post) { create(:post, user: user) }
  let!(:other_post) { create(:post, user: other_user) }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end

  describe 'ヘッダーのテスト: ログインしている場合' do
    context 'リンクの内容を確認: ※logoutは『ユーザログアウトのテスト』でテスト済み' do
      subject { current_path }

      it 'サイトロゴを押すと、トップ画面に遷移する' do
        home_link = find_all('a')[0]
        home_link.click
        is_expected.to eq '/'
      end
      it 'マイページを押すと、マイページ画面に遷移する' do
        mypage_link = find_all('a')[1]
        mypage_link.click
        is_expected.to eq '/users/' + user.id.to_s
      end
      it 'みんなの投稿一覧を押すと、みんなの投稿一覧画面に遷移する' do
        posts_link = find_all('a')[2]
        posts_link.click
        is_expected.to eq '/posts'
      end
      it 'お気に入りを押すと、マイお気に入り一覧画面に遷移する' do
        myfavorite_link = find_all('a')[3]
        myfavorite_link.click
        is_expected.to eq '/users/' + user.id.to_s + '/my_favorites'
      end
      it 'カテゴリ検索するを押すと、カテゴリ一覧画面に遷移する' do
        categories_link = find_all('a')[4]
        categories_link.click
        is_expected.to eq '/categories'
      end
    end
  end

  describe "新規投稿画面(new_post_path)のテスト" do
    before do
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