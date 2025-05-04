import 'package:dio/dio.dart';
import 'package:e_learning/core/failure/failure.dart';
import 'package:e_learning/features/notifications/data/models/notification_model/notifications_model.dart';
import 'package:e_learning/features/notifications/presentation/manager/notifications_cubit/notifications_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases/get_all_notifications_use_case.dart';

class NotificationsCubit extends Cubit<NotificationsStates> {
  final GetAllNotificationsUseCase getAllNotificationsUseCase;

  NotificationsCubit(
    this.getAllNotificationsUseCase,
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
}
