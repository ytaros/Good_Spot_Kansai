require 'rails_helper'

RSpec.describe Article, type: :model do
  let!(:prefecture) { Prefecture.create(name: "兵庫県") }
  let(:user) { User.create(
      name: "Aaron",
      prefecture:  prefecture,
      email:      "tester@example.com",
      password:   "dottle-nouveau-pavilion-tights-furze",
      password_confirmation:   "dottle-nouveau-pavilion-tights-furze"
      )
    }
  let(:category) { Category.create(name: "view" ) }
  let(:city) { City.create(name: "神戸市中央区" ) }
  let(:area) { Area.create(name: "兵庫県") }
  let(:tag) { Tag.create(name: "自然") }
  let(:photo) { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/test_image.png'), 'image/png') }

  # 必要なデータを持った有効な記事であること
  it "is valid with a title, address, text, photos, and associations" do
    article = Article.new(
      user: user,
      category: category,
      city: city,
      area: area,
      tag: tag,
      title: "Sample",
      address: "Sample Address",
      text: "Sample.",
      photos: [photo]
    )
    expect(article).to be_valid
  end

  # タイトルがなければ無効であること
  it "is invalid without a title" do
    article = Article.new(title: nil)
    article.valid?
    expect(article.errors[:title]).to include("を入力してください")
  end

  # タイトルが10文字を超えると無効であること
  it "is invalid with a title longer than 10 characters" do
    article = Article.new(title: "a" * 11)
    article.valid?
    expect(article.errors[:title]).to include("は10文字以内で入力してください")
  end

  # アドレスがなければ無効であること
  it "is invalid without an address" do
    article = Article.new(address: nil)
    article.valid?
    expect(article.errors[:address]).to include("を入力してください")
  end

  # テキストがなければ無効であること
  it "is invalid without text" do
    article = Article.new(text: nil)
    article.valid?
    expect(article.errors[:text]).to include("を入力してください")
  end

  # テキストが140文字を超えると無効であること
  it "is invalid with text longer than 140 characters" do
    article = Article.new(text: "a" * 141)
    article.valid?
    expect(article.errors[:text]).to include("は140文字以内で入力してください")
  end

  # 写真がなければ無効であること
  it "is invalid without photos" do
    article = Article.new(photos: [])
    article.valid?
    expect(article.errors[:photos]).to include("を入力してください")
  end

  # 写真の数が1枚未満または5枚以上で無効であること
  # このテストは写真のアップロード方法に依存するため、具体的な実装は異なる場合があります。
  # it "is invalid if the number of photos is less than 1 or more than 5" do
  #   article = Article.new(/* 写真の数が0または6以上 */)
  #   article.valid?
  #   expect(article.errors[:photos]).to include("の数が不正です")
  # end
end

