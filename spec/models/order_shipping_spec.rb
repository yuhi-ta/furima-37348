require 'rails_helper'
RSpec.describe OrderShipping, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_shipping = FactoryBot.build(:order_shipping , user_id: user.id, item_id: item.id)
    sleep(0.1)
  end

  describe '商品購入機能' do
    context '商品購入できる時' do
      it 'post_code、prefecture_id、municipalities、address、phone_number、token、user_id,item_idが存在すれば登録できる' do
        expect(@order_shipping).to be_valid
      end

      it '建物名が入力されても購入できる' do
        @order_shipping.building_name = 'テスト'
        expect(@order_shipping).to be_valid
      end
    end

    context '商品購入できない時' do
      it '郵便番号が空だと購入できない' do
        @order_shipping.post_code = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include "Post code can't be blank"
      end

      it '郵便番号は、「3桁ハイフン4桁」の半角文字列以外では購入できない' do
        @order_shipping.post_code = '1234-123'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include 'Post code is invalid. Include hyphen(-)'
      end

      it '都道府県が空だと購入できない' do
        @order_shipping.prefecture_id = 1
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include "Prefecture can't be blank"
      end

      it '市区町村が空だと購入できない' do
        @order_shipping.municipalities = ''
        @order_shipping.valid?
      
        expect(@order_shipping.errors.full_messages).to include "Municipalities can't be blank"
      end

      it '番地が空だと購入できない' do
        @order_shipping.address= ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include "Address can't be blank"
      end

      it '電話番号が空だと購入できない' do
        @order_shipping.phone_number = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include "Phone number can't be blank"
      end

      it '電話番号が、10桁以下では購入できない' do
        @order_shipping.phone_number = '123456789'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include 'Phone number is too short'
      end

      it '電話番号が、11桁以上では購入できない' do
        @order_shipping.phone_number = '123456789012'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include 'Phone number is too short'
      end

      it '電話番号が、全角では購入できない' do
        @order_shipping.phone_number = '１２３４５６７８９０'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include 'Phone number is invalid. Input only number'
      end

      it 'tokenが空だと購入できない' do
        @order_shipping.token = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include "Token can't be blank"
      end

      it 'use_idが空だと購入できない' do
        @order_shipping.user_id = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include "User can't be blank"
      end

      it 'item_idが空だと購入できない' do
        @order_shipping.item_id = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include "Item can't be blank"
      end
    end
  end
end
