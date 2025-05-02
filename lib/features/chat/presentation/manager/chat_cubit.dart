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


  TextEditingController chatController = TextEditingController();

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
  Stream<List<ConversationModel>>? conversationsStream ;
  List<ConversationModel> conversations = [];

  void getConversations() async{
    emit(GetConversationsLoadingState());
    try {
      conversationsStream = getConversationsUseCase.execute();
      conversationsStream!.listen((data){
        conversations = [];
        for(var conversation in data) {
          conversations.add(conversation);
        }
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


  Stream<List<MessageModel>>? messagesStreamController;
  List<MessageModel> messages = [];


  void getMessages(String instructorId) async{
    emit(GetMessagesLoadingState());
    try {

      messagesStreamController = getMessagesUseCase.execute(instructorId);
      messagesStreamController!.listen((data){
        messages = [];
        for(var message in data) {
          messages.add(message);
        }
        emit(GetConversationsSuccessState());
      });
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

  ScrollController scrollController = ScrollController();

  scroll(){
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
  }

}
