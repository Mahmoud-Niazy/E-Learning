import 'dart:async';

import 'package:e_learning/features/chat/data/models/message_model/message_model.dart';
import 'package:e_learning/features/chat/domain/repos/chat_repo.dart';

class GetMessagesUseCase {
  final ChatRepo chatRepo;
  GetMessagesUseCase(this.chatRepo);

  Stream<List<MessageModel>> execute(String instructorId){
    final StreamController<List<MessageModel>> messagesStreamController = StreamController.broadcast();
    var res = chatRepo.getMessagesOfConversation(instructorId);
    List<MessageModel> messages = [];
    res.listen((data){
     for(var message in data){
       messages.add(MessageModel.fromJson(message));
     }
     messagesStreamController.add(messages);
    });
    return messagesStreamController.stream;
  }
}