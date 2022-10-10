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
      it '新規登録を押すと、新規登録画面に遷移する' do
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
end