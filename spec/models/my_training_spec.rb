# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'MyTrainingモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { my_training.valid? }

    let(:user) { create(:user) }
    let!(:my_training) { build(:my_training, user_id: user.id) }

    context 'menuカラム' do
      it '空欄でないこと' do
        my_training.menu = ''
        is_expected.to eq false
      end
      it '2文字以上であること: 1文字は×' do
        my_training.menu = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end
      it '2文字以上であること: 2文字は〇' do
        my_training.menu = Faker::Lorem.characters(number: 2)
        is_expected.to eq true
      end
      it '30文字以下であること: 31文字は×' do
        my_training.menu = Faker::Lorem.characters(number: 16)
        is_expected.to eq false
      end
      it '30文字以下であること: 30文字は◦' do
        my_training.menu = Faker::Lorem.characters(number: 31)
        is_expected.to eq true
      end
    end

    context 'setカラム' do
      it '空欄でないこと' do
        my_training.set = ''
        is_expected.to eq false
      end
      it '2文字以上であること: 1文字は×' do
        my_training.set = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end
      it '2文字以上であること: 2文字は〇' do
        my_training.set = Faker::Lorem.characters(number: 2)
        is_expected.to eq true
      end
      it '50文字以下であること: 51文字は×' do
        my_training.set = Faker::Lorem.characters(number: 51)
        is_expected.to eq false
      end
      it '50文字以下であること: 50文字は◦' do
        my_training.set = Faker::Lorem.characters(number: 50)
        is_expected.to eq true
      end

    context 'noteカラム' do
      it '50文字以下であること: 51文字は×' do
        my_training.note = Faker::Lorem.characters(number: 51)
        is_expected.to eq false
      end
      it '50文字以下であること: 50文字は◦' do
        my_training.note = Faker::Lorem.characters(number: 50)
        is_expected.to eq true
      end
    end

  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(MyTraining.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end
