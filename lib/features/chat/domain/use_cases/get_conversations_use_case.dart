import 'dart:async';

import 'package:e_learning/features/chat/data/models/conversation_model/conversation_model.dart';
import 'package:e_learning/features/chat/domain/repos/chat_repo.dart';

class GetConversationsUseCase {
  final ChatRepo chatRepo;

  GetConversationsUseCase(this.chatRepo);

  Stream<ConversationModel> execute() {
    final StreamController<ConversationModel> conversationStreamController = StreamController.broadcast();
    var res = chatRepo.getAllConversations();
    res.listen((data) {
      conversationStreamController.add(ConversationModel.fromJson(data));
    });
    return conversationStreamController.stream;
  }
}
