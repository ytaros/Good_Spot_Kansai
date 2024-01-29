require 'rails_helper'

RSpec.describe Area, type: :model do
  let(:area) { Area.create(/* 必要な属性 */) }
  let(:city) { City.create(area: area, /* 他の属性 */) }
  let(:article) { Article.create(area: area, /* 他の属性 */) }

  # 関連付けをテスト
  it 'has many cities' do
    # let によって city がここで作成される
    expect(area.cities).to include(city)
  end

  it 'has many articles' do
    # let によって article がここで作成される
    expect(area.articles).to include(article)
  end

  # dependent: :destroy をテスト
  it 'destroys associated cities when destroyed' do
    city  # let によって city が作成される
    expect { area.destroy }.to change(City, :count).by(-1)
  end

  it 'destroys associated articles when destroyed' do
    article  # let によって article が作成される
    expect { area.destroy }.to change(Article, :count).by(-1)
  end
end
