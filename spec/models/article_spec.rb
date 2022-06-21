# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Articleモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { article.valid? }

    let(:user) { create(:user) }
    let!(:article) { build(:article, user_id: user.id) }

    context 'titleカラム' do
      it '空欄でないこと' do
        article.title = ''
        is_expected.to eq false
      end
    end

    context 'textカラム' do
      it '空欄でないこと' do
        article.text = ''
        is_expected.to eq false
      end
    end

    context 'category_idカラム' do
      it '空欄でないこと' do
        article.category_id = ''
        is_expected.to eq false
      end
    end

    context 'user_idカラム' do
      it '空欄でないこと' do
        article.user_id = ''
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Article.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end
