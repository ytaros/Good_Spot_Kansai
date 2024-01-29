require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:prefecture) { Prefecture.create(name: "兵庫県") }
    # 名前、メール、パスワード,都道府県があれば有効な状態であること
    it "is valid with a name, email, password, prefecture" do
      user = User.new(
      name: "Aaron",
      prefecture:  prefecture,
      email:      "tester@example.com",
      password:   "dottle-nouveau-pavilion-tights-furze",
      password_confirmation:   "dottle-nouveau-pavilion-tights-furze"
      )
      expect(user).to be_valid
    end

    # 名がなければ無効な状態であること
    it "is invalid without a name" do
      user = User.new(name: nil)
      user.valid?
      expect(user.errors[:name]).to include("を入力してください")
    end

    # 名前が10文字以上だと無効であること
    it "is invalid with a name longer than 10 characters" do
      user = User.new(name: "a" * 11)
      user.valid?
      expect(user.errors[:name]).to include("は10文字以内で入力してください")
    end

    # メールアドレスがなければ無効な状態であること
    it "is invalid without a email" do
      user = User.new(email: nil)
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    # 重複したメールアドレスなら無効な状態であること
    it "is invalid with a duplicate email address" do
      user = User.create(
      name: "Aaron",
      prefecture:  prefecture,
      email:      "tester@example.com",
      password:   "dottle-nouveau-pavilion-tights-furze",
      password_confirmation:   "dottle-nouveau-pavilion-tights-furze"
      )
      user = User.new(
      name: "Jone",
      prefecture:  prefecture,
      email:      "tester@example.com",
      password:   "dottle-nouveau-pavilion-tights-furze",
      password_confirmation:   "dottle-nouveau-pavilion-tights-furze"
      )
      user.valid?
      expect(user.errors[:email]).to include("はすでに存在します")
    end
    # 都道府県がなければ無効な状態であること
    it "is invalid without a prefecture" do
      user = User.new(prefecture:  nil)
      user.valid?
      expect(user.errors[:prefecture]).to include("を入力してください")
    end

    # パスワードがなければ無効な状態であること
    it "is invalid without a password" do
      user = User.new(password:  nil)
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

    # パスワードが3文字以下だと無効であること
    it "is invalid with a password shorter than 3 characters" do
    user = User.new(password: "a" * 2, password_confirmation: "a" * 2)
    user.valid?
    expect(user.errors[:password]).to include("は3文字以上で入力してください")
  end

  # パスワードと確認用パスワードが一致しなければ無効であること
  it "is invalid if password and password confirmation do not match" do
    user = User.new(password: "password", password_confirmation: "different")
    user.valid?
    expect(user.errors[:password_confirmation]).to include("とPasswordの入力が一致しません")
  end
end

# ActiveRecord::AssociationTypeMismatch というエラーが発生しています。これは、ActiveRecord（Railsのデータベースを操作するための部分）が、予期した型と異なる型のデータを受け取ったときに発生
# User オブジェクトを作成する前に、Prefecture モデルから "兵庫県" に相当するインスタンスを見つけ（または作成）し、それを user オブジェクトに割り当てます。