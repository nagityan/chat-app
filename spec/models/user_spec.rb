require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    it "nameとemail、passwordとpassword_confirmationが存在すれば登録できること" do
      expect(@user).to be_valid
    end

    it "nameが空では登録できないこと" do
      @user.name =""
      @user.valid?
      expect(@user.errors.full_messages).to include("Name can't be blank")
    end

    it "emailが空では登録できないこと" do
      @user.email =""
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it "passwordが空では登録できないこと" do
      @user.password =""
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")

    end
    it "passwordが存在してもpassword_confirmationが空では登録できないこと" do
      @user.password_confirmation =""
      # binding.pry
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "passwordが6文字以上であれば登録できること" do
      @user.name ="qqqqqqqq"
      @user.valid?
    end

    it "passwordが5文字以下であれば登録できないこと" do
      @user.password ="qq"
      @user.password_confirmation ="qq"
      # binding.pry
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    it "重複したemailが存在する場合登録できないこと" do
      @user.save
      @user1= FactoryBot.build(:user,email: @user.email)
      @user1.valid?
      # binding.pry
      expect(@user1.errors.full_messages).to include("Email has already been taken")
    end
  end
end