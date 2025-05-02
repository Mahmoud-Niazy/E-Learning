import 'dart:async';

import 'package:e_learning/features/chat/data/models/conversation_model/conversation_model.dart';
import 'package:e_learning/features/chat/domain/repos/chat_repo.dart';

class GetConversationsUseCase {
  final ChatRepo chatRepo;

  GetConversationsUseCase(this.chatRepo);

  Stream<List<ConversationModel>> execute() {
    final StreamController<List<ConversationModel>> conversationStreamController = StreamController.broadcast();
    List<ConversationModel> conversations = [];
    var res = chatRepo.getAllConversations();
    res.listen((data) {
      for(var conversation in data){
        conversations.add(ConversationModel.fromJson(conversation));
      }
      conversationStreamController.add(conversations);
    });
    return conversationStreamController.stream;
  }
}
