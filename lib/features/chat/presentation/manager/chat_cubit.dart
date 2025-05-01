import 'package:dio/dio.dart';
import 'package:e_learning/core/failure/failure.dart';
import 'package:e_learning/features/chat/domain/use_cases/get_conversations_use_case.dart';
import 'package:e_learning/features/chat/domain/use_cases/send_message_use_case.dart';
import 'package:e_learning/features/chat/presentation/manager/chat_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/conversation_model/conversation_model.dart';

class ChatCubit extends Cubit<ChatStates> {
  final SendMessageUseCase sendMessageUseCase;
  final GetConversationsUseCase getConversationsUseCase;

  ChatCubit(
    this.sendMessageUseCase,
    this.getConversationsUseCase,
  ) : super(ChatInitialState());


  void sendMessage({
    required String to,
    required String message,
  }) {
    emit(SendMessageLoadingState());
    try {
      sendMessageUseCase.execute(to, message);
      emit(SendMessageSuccessState());
    } catch (error) {
      if (error is DioException) {
        emit(
            SendMessageErrorState(ServerFailure.fromDioException(error).error));
      } else {
        emit(SendMessageErrorState(error.toString()));
      }
    }
  }
  Stream<ConversationModel>? conversations ;
  int conversationsLength = 0;

  void getConversations() {
    emit(GetConversationsLoadingState());
    try {
      conversationsLength = 0;
      conversations = getConversationsUseCase.execute();
      if(conversations != null) {
        conversations!.listen((data){
        conversationsLength ++;
      });
      }
      emit(GetConversationsSuccessState());
    } catch (error) {
      if(error is DioException){
        emit(GetConversationsErrorState(ServerFailure.fromDioException(error).error));
      }
      else{
        emit(GetConversationsErrorState(error.toString()));
      }
    }
  }
}
