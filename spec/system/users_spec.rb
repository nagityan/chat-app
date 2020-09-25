require 'rails_helper'

RSpec.describe "ユーザーログイン機能", type: :system do
  it 'ログインしていない状態でトップページにアクセスした場合、サインインページに移動する' do
    # トップページに遷移する
    visit root_path
    # ログインしていない場合、サインインページに遷移していることを確認する
    expect(current_path).to eq new_user_session_path
  end

  it 'ログインに成功し、トップページに遷移する' do
    # 予め、ユーザーをDBに保存する
    @user = FactoryBot.build(:user)
    @user.save
    # サインインページへ移動する
    visit new_user_session_path
    # ログインしていない場合、サインインページに遷移していることを確認する
    expect(current_path).to eq new_user_session_path
    # すでに保存されているユーザーのemailとpasswordを入力する
    
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    # ログインボタンをクリックする
    find('input[name = "commit"]').click
    # トップページに遷移していることを確認する
    expect(current_path).to  eq root_path

  end
  it 'ログインに失敗し、再びサインインページに戻ってくる' do
    # 予め、ユーザーをDBに保存する
    
    @user = FactoryBot.build(:user)
    @user.save
    # トップページに遷移する
    visit new_user_session_path
    # ログインしていない場合、サインインページに遷移していることを確認する
    expect(current_path).to eq new_user_session_path
    # 誤ったユーザー情報を入力する
    fill_in 'Email', with: "asf@eaff"
    fill_in 'Password', with: "ddddddd"
    # ログインボタンをクリックする
    # binding.pry
    find('input[name = "commit"]').click
    # サインインページに戻ってきていることを確認する
    expect(current_path).to eq user_session_path
  end
end