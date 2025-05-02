abstract class ChatStates {}

class ChatInitialState extends ChatStates{}

class SendMessageLoadingState extends ChatStates{}
class SendMessageSuccessState extends ChatStates{}
class SendMessageErrorState extends ChatStates{
  final String error;
  SendMessageErrorState(this.error);
}

class GetConversationsLoadingState extends ChatStates{}
class GetConversationsSuccessState extends ChatStates{}
class GetConversationsErrorState extends ChatStates{
  final String error;
  GetConversationsErrorState(this.error);
}

class GetMessagesLoadingState extends ChatStates{}
class GetMessagesSuccessState extends ChatStates{}
class GetMessagesErrorState extends ChatStates{
  final String error;
  GetMessagesErrorState(this.error);
}

class GetRealTimeLoading extends ChatStates{}
class GetRealTimeSuccess extends ChatStates{}
class GetRealTimeError extends ChatStates{}

class ScrollState extends ChatStates{}