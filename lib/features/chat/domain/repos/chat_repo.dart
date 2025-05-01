
abstract class ChatRepo {
  void sendMessage(String to , String message);
  Stream<List<Map<String,dynamic>>> getMessagesOfConversation(String instructorId);
  Stream<Map<String,dynamic>> getAllConversations();
}