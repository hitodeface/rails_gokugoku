require 'rails_helper'

RSpec.describe Foto, type: :model do

    before do
      # factories/user.rb
      @user = FactoryBot.create(:user)
    end

    describe '通常動作の確認' do
  
      it "ログイン時に投稿できるか" do 
        user = @user
        foto = user.fotos.build(
          title: "タイトル",
          body: "内容",
          image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/example.jpg'), 'image/jpg'),
          user_id: 1
          )
        expect(foto).to be_valid
      end

    end


    describe 'バリデーションチェック' do
  
      it "title" do 
        
        foto = @user.fotos.build(
          title: nil,
          body: "内容",
          image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/example.jpg'), 'image/jpg'),
          user_id: 1
          )
        expect(foto).to be_invalid
      end

      it "body" do 
        
        foto = @user.fotos.build(
          title: "title",
          body: nil,
          image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/example.jpg'), 'image/jpg'),
          user_id: 1
          )
        expect(foto).to be_invalid
      end

      it "image" do 
        
        foto = @user.fotos.build(
          title: "title",
          body: "内容",
          image: nil,
          user_id: 1
          )
        expect(foto).to be_invalid
      end

    end

end