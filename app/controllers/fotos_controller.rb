class FotosController < ApplicationController

    def index
        #検索機能
      if params[:search] != nil && params[:search] != ''
        @fotos = Foto.where("title LIKE ? ",'%' + params[:search] + '%') .or Foto.where("body LIKE ? ",'%' + params[:search] + '%')
      elsif params[:tag_name]
        @fotos = Foto.tagged_with("#{params[:tag_name]}")
      else
        @fotos = Foto.all
      end
      #ページネーション 
      @pagination = Foto.all.page(params[:page]).per(12)
      end
  
      def new
        @foto = Foto.new
      end
  
      # 投稿
      def create
        @foto = Foto.new(foto_params)
        @foto.user_id = current_user.id
        if @foto.save
          redirect_to :action => "index"
        else
          render action: :new
        end
      end
  
      #update
  
      def show
        @foto = Foto.find(params[:id])
        @fotolike = Fotolike.new
        @fotocomments = @foto.fotocomments
        @fotocomment = @foto.fotocomments.build
      end
  
      def edit
        @foto = Foto.find(params[:id])
      end
  
      def update
        @foto = Foto.find(params[:id])
        if @foto.update(foto_params)
          redirect_to :action => "show", :id => @foto.id
        else
          render action: :edit
        end
      end
  
  
      def destroy
        Foto.find(params[:id]).destroy
        redirect_to action: :index
      end
  
      #認証　投稿一覧と詳細は認証を外す
      before_action :authenticate_user!, except: [:index, :show]
      
      private
  
    def foto_params
      params.require(:foto).permit(:title,:body,:image,:tag_list)
    end
  
  
  
  
  
  
  end