class ChatsController < ApplicationController
  
   #UserA情報を取得
     #user_roomsテーブルのuser_idがログイン中UserBのレコードのroom_idを配列で取得
     #user_idがログイン中UserBで、room_idがUserAさんの属するroom_id（配列）となるuser_roomsテーブルのレコードを取得して、user_room変数に格納
     #これによって、AさんとBさんに共通のroom_idが存在していれば、その共通のroom_idとBさんのuser_idがuser_room変数に格納される（1レコード）。存在しなければ、nilになる。
  def show
     @user = User.find(params[:user_id])
     rooms = current_user.user_rooms.pluck(:room_id)
     user_room = UserRoom.find_by(user_id: @user.id, room_id: rooms)
         
     #user_roomでルームを取得できなかった（AさんとBさんのチャットがまだ存在しない）場合の処理  
     #roomのidを採番
     #採番したroomのidを使って、user_roomのレコードを2人分（Aさん用、Ｂさん用）作る（＝AさんとBさんに共通のroom_idを作る）
     #Bさんの@user.idをuser_idとして、room.idをroom_idとして、UserRoomモデルのがラムに保存（1レコード）
     #Aさんのcurrent_user.idをuser_idとして、room.idをroom_idとして、UserRoomモデルのカラムに保存（1レコード）
     #user_roomに紐づくroomsテーブルのレコードをroomに格納
     @room = nil
     if user_room.nil?
      @room = Room.new
      @room.save
      UserRoom.create(user_id: @user.id, room_id: @room.id)
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
     else
       @room = user_room.room
     end
     
      #roomに紐づくchatsテーブルのレコードを@chatsに格納
      #form_withでチャットを送信する際に必要な空のインスタンス
      #ここでroom.idを@chatに代入しておかないと、form_withで記述するroom_idに値が渡らない
      @chats = @room.chats
      @chat = Chat.new(room_id: @room.id)

      # 相互フォローしていない場合はURLから遷移できないように設定  
      if current_user != @user && current_user.follow_by?(@user) && @user.follow_by?(current_user)
          chat_path(@user.id)
      else
          redirect_to user_path(current_user)
      end
      
  end

  def create
    @user = UserRoom.where(room_id:params[:room_id]).where.not(user_id: current_user.id).first.user
    @room = Room.find(params[:room_id])
    @chats = @room.chats
    @chat_new = current_user.chats.new(chat_params)
    if @chat_new.save
         @chat = Chat.new(room_id: @room.id) # 既存のファイルを消す再度空を読み込ませる為
    else
        @alert = "『文字数を1文字以上』又は『添付ファイルを5枚以内』にして下さい"
        render :errors # renderするとJSファイルが読み込まれる為、errors.jsを呼ぶように指示している
    end
  end
  
  def destroy
    @user = UserRoom.where(room_id:params[:room_id]).where.not(user_id: current_user.id).first.user
    @room = Room.find(params[:room_id])
    @chats = @room.chats
    chat = Chat.find(params[:id])
    chat.destroy
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :room_id, images: [])
  end

end
