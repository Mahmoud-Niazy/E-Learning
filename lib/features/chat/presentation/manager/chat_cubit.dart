import 'dart:async';

import 'package:dio/dio.dart';
import 'package:e_learning/core/failure/failure.dart';
import 'package:e_learning/features/chat/data/models/message_model/message_model.dart';
import 'package:e_learning/features/chat/domain/use_cases/get_conversations_use_case.dart';
import 'package:e_learning/features/chat/domain/use_cases/get_messages_use_case.dart';
import 'package:e_learning/features/chat/domain/use_cases/send_message_use_case.dart';
import 'package:e_learning/features/chat/presentation/manager/chat_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/conversation_model/conversation_model.dart';
import 'package:e_learning/core/scocket_io_services/socket_services.dart';


class ChatCubit extends Cubit<ChatStates> {
  final SendMessageUseCase sendMessageUseCase;
  final GetConversationsUseCase getConversationsUseCase;
  final GetMessagesUseCase getMessagesUseCase;
  final SocketService socket ;


  ChatCubit(
    this.sendMessageUseCase,
    this.getConversationsUseCase,
      this.getMessagesUseCase,
      this.socket,
  ) : super(ChatInitialState());


  void sendMessage({
    required String to,
  }) {
    emit(SendMessageLoadingState());
    try {
      sendMessageUseCase.execute(to, chatController.text);
      emit(SendMessageSuccessState());
      chatController.text = '';
    } catch (error) {
      if (error is DioException) {
        emit(
            SendMessageErrorState(ServerFailure.fromDioException(error).error));
      } else {
        emit(SendMessageErrorState(error.toString()));
      }
    }
  }
  Stream<ConversationModel>? conversationsStream ;
  List<ConversationModel> conversations = [];

  void getConversations() async{
    emit(GetConversationsLoadingState());
    try {
      conversationsStream = getConversationsUseCase.execute();
      conversationsStream!.listen((data){
        conversations = [];
        conversations.add(data);
        emit(GetConversationsSuccessState());
      });
    } catch (error) {
      if(error is DioException){
        emit(GetConversationsErrorState(ServerFailure.fromDioException(error).error));
      }
      else{
        emit(GetConversationsErrorState(error.toString()));
      }
    }
  }


  final StreamController<List<dynamic>> messagesStreamController = StreamController.broadcast();
  TextEditingController chatController = TextEditingController();
  List<MessageModel> messages = [];
  ScrollController scrollController = ScrollController();



  void getMessages(String instructorId) async{
    emit(GetMessagesLoadingState());
    try {
      socket.emit("getConversationMessages", instructorId);
      socket.on("getConversationMessages", (data) {
        for(var message in data){
          messages.add(MessageModel.fromJson(message));
        }
        messagesStreamController.add(messages);
      });
      emit(GetMessagesSuccessState());
    } catch (error) {
      if(error is DioException){
        emit(GetMessagesErrorState(ServerFailure.fromDioException(error).error));
      }
      else{
        emit(GetMessagesErrorState(error.toString()));
      }
    }
  }
  
  void receiveRealTimeMessage(){
    emit(GetRealTimeLoading());
    socket.on("receiveMessage", (data){
      messages.add(MessageModel.fromJson(data['message']));
      emit(GetRealTimeSuccess());
    });
  }

  scroll(){
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
  }

}
