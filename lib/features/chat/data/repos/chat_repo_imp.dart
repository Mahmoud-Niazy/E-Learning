import 'dart:async';
import 'dart:developer';
import 'package:e_learning/core/scocket_io_services/socket_services.dart';
import 'package:e_learning/features/chat/domain/repos/chat_repo.dart';

class ChatRepoImp extends ChatRepo{
  final SocketService socket ;

  ChatRepoImp(this.socket);

  @override
  void sendMessage(String to, String message) {
    socket.emit("sendMessage", [to,message]);
  }

  @override
  Stream<List<dynamic>> getMessagesOfConversation(String instructorId) {
    final StreamController<List<dynamic>> messagesStreamController = StreamController.broadcast();
    socket.emit("getConversationMessages", instructorId);
    socket.on("getConversationMessages", (data) {
      messagesStreamController.add(data);
    });
    return messagesStreamController.stream;
  }

  @override
  Stream<Map<String,dynamic>> getAllConversations() {
    final StreamController<Map<String,dynamic>> conversationStreamController = StreamController.broadcast();
    socket.emit("getConversations", null);
    socket.on("getConversations", (data) {
      var res = data['conversations'][0];
      conversationStreamController.add(res);
    });
    return conversationStreamController.stream;
  }

}