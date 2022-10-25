require "rails_helper"

describe "[STEP2] ユーザログイン後のテスト" do
  let(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:post) { create(:post, user: user, privacy: 0) }
  let!(:other_post) { create(:post, user: other_user, privacy: 0) }

  before do
    visit new_user_session_path
    fill_in "user[email]", with: user.email
    fill_in "user[password]", with: user.password
    click_button "ログイン"
  end

  describe "ヘッダーのテスト: ログインしている場合" do
    context "リンクの内容を確認: ※logoutは『ユーザログアウトのテスト』でテスト済み" do
      subject { current_path }

      it "サイトロゴを押すと、トップ画面に遷移する" do
        home_link = find_all("a")[0]
        home_link.click
        is_expected.to eq "/"
      end
      it "マイページを押すと、マイページ画面に遷移する" do
        mypage_link = find_all("a")[1]
        mypage_link.click
        is_expected.to eq "/users/" + user.id.to_s
      end
      it "みんなの投稿一覧を押すと、みんなの投稿一覧画面に遷移する" do
        posts_link = find_all("a")[2]
        posts_link.click
        is_expected.to eq "/posts"
      end
      it "お気に入りを押すと、マイお気に入り一覧画面に遷移する" do
        myfavorite_link = find_all("a")[3]
        myfavorite_link.click
        is_expected.to eq "/users/" + user.id.to_s + "/my_favorites"
      end
      it "カテゴリ検索するを押すと、カテゴリ一覧画面に遷移する" do
        categories_link = find_all("a")[4]
        categories_link.click
        is_expected.to eq "/categories"
      end
    end
  end

  describe "みんなの投稿一覧画面のテスト" do
    before do
      visit posts_path
    end

    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq "/posts"
      end
      it "自分とのニックネームのリンク先と表示が正しい" do
        expect(page).to have_link post.user.nickname, href: user_path(post.user)
        click_link post.user.nickname
        expect(page).to have_content "マイページ"
      end
      it "他人のニックネームのリンク先と表示が正しい" do
        expect(page).to have_link other_post.user.nickname, href: user_path(other_post.user)
        click_link other_post.user.nickname
        expect(page).to have_content "プロフィール"
      end
      it "商品画像を押すと、投稿詳細画面に遷移する" do
        expect(page).to have_link "", href: post_path(post)
      end
      it "「商品名」が表示される" do
        expect(page).to have_content post.item_name
      end
      it "「コメント件数」が表示される" do
        expect(page).to have_content post.post_comments.count
      end
      it "「ユーザーニックネーム」が表示される" do
        expect(page).to have_content post.user.nickname
      end
    end
  end

  describe "自分の投稿詳細画面のテスト" do
    before do
      visit post_path(post)
    end

    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq "/posts/" + post.id.to_s
      end
      it "「商品レビュー詳細」と表示される" do
        expect(page).to have_content "商品レビュー詳細"
      end
      it "投稿日時が表示される" do
        expect(page).to have_content post.created_at.strftime("%Y/%m/%d %H:%M:%S")
      end
      it "商品名が表示される" do
        expect(page).to have_content post.item_name
      end
      it "商品カテゴリ名が表示される" do
        expect(page).to have_content post.item_category.name
      end
      it "投稿のレビュータイトルが表示される" do
        expect(page).to have_content post.review_title
      end
      it "投稿のレビュー本文が表示される" do
        expect(page).to have_content post.review_body
      end
      it "投稿の編集リンクが表示される" do
        expect(page).to have_link "投稿を編集する", href: edit_post_path(post)
      end
      it "投稿の削除リンクが表示される" do
        expect(page).to have_link "削除する", href: post_path(post)
      end
    end

    context "いいねの確認" do
      it "リンクが諸々正しい" do
        expect(page).to have_link "", href: post_post_favorites_path(post) # リンクが正しい
        expect(page).to have_css("i.far") # いいねの表示
        expect(page).to have_css("i.fas") # いいね済の表示
      end
    end

    context "編集リンクのテスト" do
      it "編集画面に遷移する" do
        click_link "編集する"
        expect(current_path).to eq "/posts/" + post.id.to_s + "/edit"
      end
    end

    context "削除リンクのテスト" do
      it "application.html.erbにjavascript_pack_tagを含んでいる" do
        is_exist = 0
        open("app/views/layouts/application.html.erb").each do |line|
          strip_line = line.chomp.delete(" ")
          if strip_line.include?("<%=javascript_pack_tag'application','data-turbolinks-track':'reload'%>")
            is_exist = 1
            break
          end
        end
        expect(is_exist).to eq(1)
      end
      before do
        click_link "削除"
      end
      it "正しく削除される" do
        expect(Post.where(id: post.id).count).to eq 0
      end
      it "リダイレクト先が、投稿一覧画面になっている" do
        expect(current_path).to eq "/posts"
      end
    end
  end

  describe "他人の投稿詳細画面のテスト" do
    before do
      visit post_path(other_post)
    end

    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq "/posts/" + other_post.id.to_s
      end
      it "投稿の編集リンクが表示されない" do
        expect(page).not_to have_link "投稿を編集する", href: edit_post_path(post)
      end
      it "投稿の削除リンクが表示されない" do
        expect(page).not_to have_link "削除する", href: post_path(post)
      end
    end
  end

  describe "新規投稿画面(new_post_path)のテスト" do
    before do
      visit new_post_path
    end

    context "表示の確認" do
      it 'new_post_pathが"/posts/new"であるか' do
        expect(current_path).to eq("/posts/new")
      end
      it "新規投稿ボタンが表示されているか" do
        expect(page).to have_button "新規投稿"
      end
    end
  end
end
