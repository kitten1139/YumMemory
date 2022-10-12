require 'rails_helper'

describe '[STEP1] ユーザログイン前のテスト' do
  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end

    context '表示の確認' do
      it 'トップ画面(root_path)に「新着レビュー」が表示されているか' do
        expect(page).to have_content '新着レビュー'
      end
      it 'root_pathが"/"であるか' do
        expect(current_path).to eq('/')
      end
    end
  end

  describe 'アバウト画面(サイト概要)のテスト' do
    before do
      visit '/about'
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/about'
      end
    end
  end

  describe 'ヘッダーのテスト: ログインしていない場合' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'サイトロゴ(トップ画面へのリンク)が表示される: 左上から1番目のリンクが「サイトロゴ」である' do
        home_link = find_all('a')[0].native.inner_text
        expect(home_link).to match(//)
      end
      it 'サイト概要リンクが表示される: 左上から2番目のリンクが「サイト概要」である' do
        about_link = find_all('a')[1].native.inner_text
        expect(about_link).to match(/サイト概要/)
      end
      it 'ゲストログイン(閲覧用)リンクが表示される: 左上から3番目のリンクが「ゲストログイン(閲覧用)」である' do
        guest_login_link = find_all('a')[2].native.inner_text
        expect(guest_login_link).to match(/ゲストログイン/)
      end
      it '新規登録リンクが表示される: 左上から4番目のリンクが「新規登録」である' do
        signup_link = find_all('a')[3].native.inner_text
        expect(signup_link).to match(/新規登録/)
      end
      it 'ログインリンクが表示される: 左上から5番目のリンクが「ログイン」である' do
        login_link = find_all('a')[4].native.inner_text
        expect(login_link).to match(/ログイン/)
      end
    end

    context 'リンクの内容を確認' do
      subject { current_path }

      it 'サイトロゴを押すと、トップ画面に遷移する' do
        home_link = find_all('a')[0]
        home_link.click
        is_expected.to eq '/'
      end
      it 'サイト概要を押すと、アバウト画面に遷移する' do
        about_link = find_all('a')[1]
        about_link.click
        is_expected.to eq '/about'
      end
      it 'ゲストログイン(閲覧用)を押すと、みんなの投稿一覧画面に遷移する' do
        guest_login_link = find_all('a')[2]
        guest_login_link.click
        is_expected.to eq '/posts'
      end
      it '新規登録を押すと、新規会員登録画面に遷移する' do
        signup_link = find_all('a')[3]
        signup_link.click
        is_expected.to eq '/users/sign_up'
      end
      it 'ログインを押すと、ログイン画面に遷移する' do
        login_link = find_all('a')[4]
        login_link.click
        is_expected.to eq '/users/sign_in'
      end
    end
  end

  describe 'ユーザ新規登録のテスト' do
    before do
      visit new_user_registration_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/sign_up'
      end
      it '「新規会員登録」と表示される' do
        expect(page).to have_content '新規会員登録'
      end
      it 'メールアドレスフォームが表示される' do
        expect(page).to have_field 'user[email]'
      end
      it 'パスワードフォームが表示される' do
        expect(page).to have_field 'user[password]'
      end
      it 'パスワード確認フォームが表示される' do
        expect(page).to have_field 'user[password_confirmation]'
      end
      it 'プロフィール画像フォームが表示される' do
        expect(page).to have_field 'user[image]'
      end
      it 'ニックネームフォームが表示される' do
        expect(page).to have_field 'user[nickname]'
      end
      it '居住地フォームが表示される' do
        expect(page).to have_field 'user[prefecture]'
      end
      it '性別フォームが表示される' do
        expect(page).to have_field 'user[gender]'
      end
      it '年齢フォームが表示される' do
        expect(page).to have_field 'user[age]'
      end
      it '好きな食べ物フォームが表示される' do
        expect(page).to have_field 'user[favorite_food]'
      end
      it '自己紹介フォームが表示される' do
        expect(page).to have_field 'user[introduction]'
      end
      it '新規登録ボタンが表示される' do
        expect(page).to have_button '新規登録'
      end
    end

    context '新規登録成功のテスト' do
      before do
        fill_in 'user[email]', with: Faker::Internet.email
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        fill_in 'user[nickname]', with: Faker::Lorem.characters(number: 10)
      end

      it '正しく新規登録される' do
        expect { click_button '新規登録' }.to change(User.all, :count).by(1)
      end
      it '新規登録後のリダイレクト先が、新規登録できたユーザの詳細画面になっている' do
        click_button '新規登録'
        expect(current_path).to eq '/users/' + User.last.id.to_s
      end
    end
  end

  describe 'ユーザログイン' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/sign_in'
      end
      it '「ログイン」と表示される' do
        expect(page).to have_content 'ログイン'
      end
      it 'メールアドレスフォームが表示される' do
        expect(page).to have_field 'user[email]'
      end
      it 'パスワードフォームが表示される' do
        expect(page).to have_field 'user[password]'
      end
      it 'ログインボタンが表示される' do
        expect(page).to have_button 'ログイン'
      end
    end

    context 'ログイン成功のテスト' do
      before do
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'ログイン'
      end

      it 'ログイン後のリダイレクト先が、みんなの投稿一覧画面になっている' do
        expect(current_path).to eq '/posts'
      end
    end

    context 'ログイン失敗のテスト' do
      before do
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        click_button 'ログイン'
      end

      it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
        expect(current_path).to eq '/users/sign_in'
      end
    end
  end

  describe 'ヘッダーのテスト: ログインしている場合' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
    end

    context 'ヘッダーの表示を確認' do
      it 'サイトロゴ(トップ画面へのリンク)が表示される: 左上から1番目のリンクが「サイトロゴ」である' do
        home_link = find_all('a')[0].native.inner_text
        expect(home_link).to match(//)
      end
      it 'マイページリンクが表示される: 左上から3番目のリンクが「マイページ」である' do
        mypage_link = find_all('a')[1].native.inner_text
        expect(mypage_link).to match(/マイページ/)
      end
      it 'みんなの投稿一覧リンクが表示される: 左上から1番目のリンクが「みんなの投稿一覧」である' do
        posts_link = find_all('a')[2].native.inner_text
        expect(posts_link).to match(/みんなの投稿一覧/)
      end
      it 'お気に入りリンクが表示される: 左上から4番目のリンクが「お気に入り」である' do
        myfavorite_link = find_all('a')[3].native.inner_text
        expect(myfavorite_link).to match(/お気に入り/)
      end
      it 'カテゴリで検索するリンクが表示される: 左上から5番目のリンクが「カテゴリで検索する」である' do
        categories_link = find_all('a')[4].native.inner_text
        expect(categories_link).to match(/カテゴリで検索する/)
      end
      it 'ログアウトリンクが表示される: 左上から6番目のリンクが「ログアウト」である' do
        logout_link = find_all('a')[5].native.inner_text
        expect(logout_link).to match(/ログアウト/)
      end
    end
  end

  describe 'ユーザログアウトのテスト' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
      logout_link = find_all('a')[5]
      logout_link.click
    end

    context 'ログアウト機能のテスト' do
      it 'ログアウト後のリダイレクト先が、トップになっている' do
        expect(current_path).to eq '/'
      end
    end
  end
end