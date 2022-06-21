require 'rails_helper'

describe '[STEP1] ユーザログイン前のテスト' do
  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/'
      end
      it 'ログインリンクが表示される ' do
        log_in_link = find_all('a')[5].native.inner_text
        expect(log_in_link).to match(/ログイン/)
      end
      it 'Log inリンクの内容が正しい' do
        log_in_link = find_all('a')[5].native.inner_text
        expect(page).to have_link log_in_link, href: new_user_session_path
      end
      it '新規登録リンクが表示される' do
        sign_up_link = find_all('a')[6].native.inner_text
        expect(sign_up_link).to match(/新規登録/)
      end
      it '新規登録リンクの内容が正しい' do
        sign_up_link = find_all('a')[6].native.inner_text
        expect(page).to have_link sign_up_link, href: new_user_registration_path
      end
      it 'ゲストログインリンクが表示される' do
        guest_sign_in_link = find_all('a')[6].native.inner_text
        expect(guest_sign_in_link).to match(/ゲストログイン/)
      end
      it 'ゲストログインリンクの内容が正しい' do
        guest_sign_in_link = find_all('a')[6].native.inner_text
        expect(page).to have_link guest_sign_in_link, href: users_guest_sign_in_path
      end
    end
  end

  describe 'アバウト画面のテスト' do
    before do
      visit 'public/home/about'
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq 'public/home/about'
      end
    end
  end

  describe 'ヘッダーのテスト: ログインしていない場合' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'FitHapiロゴが表示される: 左上から1番目のリンクが「FitHapi」である' do
        home_link = find_all('a')[0].native.inner_image
        expect(home_link).to match(/FitHapi_logo/)
      end
      it '新着記事リンクが表示される: 左上から2番目のリンクが「新着記事」である' do
        new_arrival_link = find_all('a')[1].native.inner_text
        expect(new_arrival_link).to match(/新着記事/)
      end
      it '人気記事リンクが表示される: 左上から3番目のリンクが「人気記事」である' do
        hot_link = find_all('a')[2].native.inner_text
        expect(hot_link).to match(/人気記事/)
      end
      it '新規登録リンクが表示される: 左上から4番目のリンクが「新規登録」である' do
        signup_link = find_all('a')[3].native.inner_text
        expect(signup_link).to match(/新規登録/)
      end
      it 'ログインリンクが表示される: 左上から5番目のリンクが「ログイン」である' do
        login_link = find_all('a')[4].native.inner_text
        expect(login_link).to match(/ログイン/)
      end
      it 'ゲストログインリンクが表示される: 左上から6番目のリンクが「ゲストログイン」である' do
        guest_sign_in_link = find_all('a')[4].native.inner_text
        expect(guest_sign_in_link).to match(/ゲストログイン/)
      end
    end

    context 'リンクの内容を確認' do
      subject { current_path }

      it 'FitHapiを押すと、トップ画面に遷移する' do
        home_link = find_all('a')[0].native.inner_text
        home_link = home_link.delete(' ')
        home_link.gsub!(/\n/, '')
        click_link home_link
        is_expected.to eq '/'
      end
      it '新着記事を押すと、新着記事画面に遷移する' do
        new_arrival_link = find_all('a')[1].native.inner_text
        new_arrival_link = home_link.delete(' ')
        new_arrival_link.gsub!(/\n/, '')
        click_link new_arrival_link
        is_expected.to eq '/new_arrival'
      end
      it '人気記事を押すと、人気記事画面に遷移する' do
        hot_link = find_all('a')[2].native.inner_text
        hot_link = hot_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link hot_link
        is_expected.to eq '/hot'
      end
      it '新規登録を押すと、新規登録画面に遷移する' do
        signup_link = find_all('a')[3].native.inner_text
        signup_link = signup_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link signup_link, match: :first
        is_expected.to eq '/users/sign_up'
      end
      it 'ログインを押すと、ログイン画面に遷移する' do
        login_link = find_all('a')[4].native.inner_text
        login_link = login_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link login_link, match: :first
        is_expected.to eq '/users/sign_in'
      end
      it 'ゲストログインを押すと、ゲストログイン画面に遷移する' do
        guest_sign_in_link = find_all('a')[4].native.inner_text
        guest_sign_in_link = login_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link guest_sign_in_link, match: :first
        is_expected.to eq '/users/guest_sign_in'
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
      it 'nameフォームが表示される' do
        expect(page).to have_field 'user[name]'
      end
      it 'accountフォームが表示される' do
        expect(page).to have_field 'user[account]'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'user[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'user[password]'
      end
      it 'password_confirmationフォームが表示される' do
        expect(page).to have_field 'user[password_confirmation]'
      end
      it 'ゲストログインボタンが表示される' do
        expect(page).to have_button 'ゲストログイン'
      end
      it 'ログインボタンが表示される' do
        expect(page).to have_button 'ログイン'
      end
    end

    context '新規登録成功のテスト' do
      before do
        fill_in 'user[name]', with: Faker::Lorem.characters(number: 5)
        fill_in 'user[account]', with: Faker::Lorem.characters(number:12)
        fill_in 'user[email]', with: Faker::Internet.email
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
      end

      it '正しく新規登録される' do
        expect { click_button '新規登録' }.to change(User.all, :count).by(1)
      end
      it '新規登録後のリダイレクト先が、トップページになっている' do
        click_button '新規登録'
        expect(current_path).to eq '/'
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
        expect(page).to have_content 'Log in'
      end
      it 'Emailフォームが表示される' do
        expect(page).to have_field 'user[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'user[password]'
      end
      it 'ログインボタンが表示される' do
        expect(page).to have_button 'ログイン'
      end
      it 'nameフォームは表示されない' do
        expect(page).not_to have_field 'user[name]'
      end
      it 'accountフォームは表示されない' do
        expect(page).not_to have_field 'user[account]'
      end
    end

    context 'ログイン成功のテスト' do
      before do
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'ログイン'
      end

      it 'ログイン後のリダイレクト先が、トップページになっている' do
        expect(current_path).to eq '/'
      end
    end

    context 'ログイン失敗のテスト' do
      before do
        fill_in 'user[name]', with: ''
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
      fill_in 'user[email]', with: user.name
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
    end

    context 'ヘッダーの表示を確認' do
      it 'FitHapiリンクが表示される: 左上から1番目のリンクが「FitHapi」である' do
        home_link = find_all('a')[0].native.inner_text
        expect(home_link).to match(/Bookers/)
      end
      it '新着記事リンクが表示される: 左上から2番目のリンクが「新着記事」である' do
        new_arrival_link = find_all('a')[1].native.inner_text
        expect(new_arrival_link).to match(/新着記事/)
      end
      it '人気記事リンクが表示される: 左上から3番目のリンクが「人気記事」である' do
        hot_link = find_all('a')[2].native.inner_text
        expect(hot_link).to match(/人気記事/)
      end
      it 'マイページリンクが表示される: 左上から4番目のリンクが「マイページ」である' do
        mypage_link = find_all('a')[4].native.inner_text
        expect(mypage_link).to match(/マイページ/)
      end
      it 'まいトレリンクが表示される: 左上から5番目のリンクが「まいトレ」である' do
        users_link = find_all('a')[5].native.inner_text
        expect(users_link).to match(/まいトレ/)
      end
      it 'ログアウトリンクが表示される: 左上から5番目のリンクが「ログアウト」である' do
        logout_link = find_all('a')[6].native.inner_text
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
      logout_link = find_all('a')[6].native.inner_text
      logout_link = logout_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      click_link logout_link
    end

    context 'ログアウト機能のテスト' do
      it '正しくログアウトできている: ログアウト後のリダイレクト先においてAbout画面へのリンクが存在する' do
        expect(page).to have_link '', href: '/users/guest_sign_in'
      end
      it 'ログアウト後のリダイレクト先が、トップになっている' do
        expect(current_path).to eq '/'
      end
    end
  end
end
