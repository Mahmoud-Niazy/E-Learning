import 'package:dio/dio.dart';
import 'package:e_learning/core/failure/failure.dart';
import 'package:e_learning/features/notifications/data/models/notification_model/notifications_model.dart';
import 'package:e_learning/features/notifications/domain/use_cases/make_all_notifications_as_seen_use_case.dart';
import 'package:e_learning/features/notifications/domain/use_cases/make_notification_as_seen_use_case.dart';
import 'package:e_learning/features/notifications/presentation/manager/notifications_cubit/notifications_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/scocket_io_services/socket_services.dart';
import '../../../domain/use_cases/get_all_notifications_use_case.dart';

class NotificationsCubit extends Cubit<NotificationsStates> {
  final GetAllNotificationsUseCase getAllNotificationsUseCase;
  final MakeAllNotificationsAsSeenUseCase makeAllNotificationsAsSeenUseCase;
  final MakeNotificationAsSeenUseCase makeNotificationAsSeenUseCase;
  final SocketService socket ;

  NotificationsCubit(
    this.getAllNotificationsUseCase,
      this.makeAllNotificationsAsSeenUseCase,
      this.makeNotificationAsSeenUseCase,
      this.socket,
  ) : super(NotificationsInitialState());


  List<NotificationModel> notifications = [];
  Future<void> getAllNotifications ()async {
    emit(GetAllNotificationsLoadingState());
    try{
      notifications = await getAllNotificationsUseCase.execute();
      notifications.sort((a, b) {
        final dateA = DateTime.parse(a.createdAt!);
        final dateB = DateTime.parse(b.createdAt!);
        return dateB.compareTo(dateA); // Newest first
      });
      emit(GetAllNotificationsSuccessState());
    }
    catch(error){
      if(error is DioException){
        emit(GetAllNotificationsErrorState(ServerFailure.fromDioException(error).error));
      }
      else{
        emit(GetAllNotificationsErrorState(error.toString()));
      }
    }
  }

  Future<void> makeAllNotificationsSeen()async{
    emit(MakeAllNotificationsSeenLoadingState());
    try{
      await makeAllNotificationsAsSeenUseCase.execute();
      emit(MakeAllNotificationsSeenSuccessState());
    }
        catch(error){
      if(error is DioException){
        emit(MakeAllNotificationsSeenErrorState(ServerFailure.fromDioException(error).error));
      }
      else{
        emit(MakeAllNotificationsSeenErrorState(error.toString()));
      }
        }
  }

  Future<void> makeNotificationSeen(String notificationId)async{
    emit(MakeNotificationSeenLoadingState());
    try{
      await makeNotificationAsSeenUseCase.execute(notificationId);
      emit(MakeNotificationSeenSuccessState());
    }
        catch(error){
          if(error is DioException){
            emit(MakeNotificationSeenErrorState(ServerFailure.fromDioException(error).error));
          }
          else{
            emit(MakeNotificationSeenErrorState(error.toString()));
          }
        }
  }

  void receiveRealTimeNotifications(){
    emit(ReceiveRealTimeNotificationsLoadingState());
    socket.on('receiveNotification', (data){
      print('====================Data==========================');
      print(data);
      print('====================Data==========================');
      notifications.add(NotificationModel.fromJson(data['notification']));
      emit(ReceiveRealTimeNotificationsSuccessState());
    });
  }
}
