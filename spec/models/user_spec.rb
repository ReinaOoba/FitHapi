# frozen_string_literal: trues

require 'rails_helper'

RSpec.describe "Userモデルのテスト", type: :model do
  describe 'バリデーションのテスト' do
    subject { user.valid? }

    let!(:other_user) { create(:user) }
    let(:user) { build(:user) }

    context 'nameカラム' do
      it '空欄でないこと' do
        user.name = ''
        is_expected.to eq false
      end
      it '15文字以下であること: 15文字は〇' do
        user.name = Faker::Lorem.characters(number: 15)
        is_expected.to eq true
      end
      it '15文字以下であること: 16文字は×' do
        user.name = Faker::Lorem.characters(number: 16)
        is_expected.to eq false
      end
    end

    context 'accountカラム' do
      it '空欄でないこと' do
        user.account = ''
        is_expected.to eq false
      end
      it '4文字以上であること: 3文字は×' do
        user.account = Faker::Lorem.characters(number: 3)
        is_expected.to eq false
      end
      it '4文字以上であること: 4文字は〇' do
        user.account = Faker::Lorem.characters(number: 4)
        is_expected.to eq true
      end
      it '一意性があること' do
        user.account = other_account.name
        is_expected.to eq false
      end
    end

    context 'introductionカラム' do
      it '3文字以上であること: 2文字は×' do
        user.introduction = Faker::Lorem.characters(number: 2)
        is_expected.to eq false
      end
      it '150文字以下であること: 151文字は×' do
        user.introduction = Faker::Lorem.characters(number: 151)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Articleモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:articles).macro).to eq :has_many
      end
    end
    context 'MyTrainingモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:my_trainings).macro).to eq :has_many
      end
    end
  end
end
