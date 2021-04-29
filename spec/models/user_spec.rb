require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  # ユーザー名、メール、パスワードがあれば有効な状態であること
  it "is valid with a first name, last name, email, and password" do
    user = User.new(
      username: "テスト１",
      email:      "test1@example.com",
      password:   "111111",
  )
    expect(user).to be_valid
  end

  # ユーザー名がなければ無効な状態であること 
  it "is invalid without a first name" do
    user = User.new(username: nil)
    user.valid?
    expect(user.errors[:username]).to include("は4文字以上で入力してください", "を入力してください")
  end


  # メールアドレスがなければ無効な状態であること 
  it "is invalid without an email address" do

    User.create(
      username: "テスト１",
      email:      "test1@example.com",
      password:   "111111",
    )

    user = User.new(
      username: "テスト２",
      email:      "test1@example.com",
      password:   "111111",
    )
    user.valid?
    expect(user.errors[:email]).to include("はすでに存在します")

  end


  # 重複したメールアドレスなら無効な状態であること 
  it "is invalid with a duplicate email address"
  # ユーザーのフルネームを文字列として返すこと
  it "returns a user's full name as a string"

end
