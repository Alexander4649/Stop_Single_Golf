class ChatsController < ApplicationController
  
  def show
     @user = User.find(params[:id])
     rooms = current_user.user_rooms.pluck(:room_id)
     user_room = UserRoom.find_by(user_id: @user.id, room_id: rooms)
     #UserA情報を取得
     #user_roomsテーブルのuser_idがログイン中UserBのレコードのroom_idを配列で取得
     #user_idがログイン中UserBで、room_idがUserAさんの属するroom_id（配列）となるuser_roomsテーブルのレコードを取得して、user_room変数に格納
     #これによって、AさんとBさんに共通のroom_idが存在していれば、その共通のroom_idとBさんのuser_idがuser_room変数に格納される（1レコード）。存在しなければ、nilになる。
     
     room = nil
     if user_room.nil?
      room = Room.new
      room.save
      UserRoom.create(user_id: @user.id, room_id: room.id)
      UserRoom.create(user_id: current_user.id, room_id: room.id)
     else
       room = user_room.room
     end
     #user_roomでルームを取得できなかった（AさんとBさんのチャットがまだ存在しない）場合の処理  
     #roomのidを採番
     #採番したroomのidを使って、user_roomのレコードを2人分（Aさん用、Ｂさん用）作る（＝AさんとBさんに共通のroom_idを作る）
     #Bさんの@user.idをuser_idとして、room.idをroom_idとして、UserRoomモデルのがラムに保存（1レコード）
     #Aさんのcurrent_user.idをuser_idとして、room.idをroom_idとして、UserRoomモデルのカラムに保存（1レコード）
     #user_roomに紐づくroomsテーブルのレコードをroomに格納
  
      @chats = room.chats
      @chat = Chat.new(room_id: room.id)
      #roomに紐づくchatsテーブルのレコードを@chatsに格納
      #form_withでチャットを送信する際に必要な空のインスタンス
      #ここでroom.idを@chatに代入しておかないと、form_withで記述するroom_idに値が渡らない
  end

  def create
    @chat = current_user.chats.new(chat_params)
    @chat.save
    redirect_to request.referer
  end
  
  def destroy
    @chat = current_user.chats.find(params[:chat_id])
    @chat.destroy
    redirect_to request.referer
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end

end
