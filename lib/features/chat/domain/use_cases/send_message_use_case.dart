import '../repos/chat_repo.dart';

class SendMessageUseCase {
  final ChatRepo chatRepo ;
  SendMessageUseCase(this.chatRepo);

  void execute(String to , String message){
    chatRepo.sendMessage(to, message);
  }
}