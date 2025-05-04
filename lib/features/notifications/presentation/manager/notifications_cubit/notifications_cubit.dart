import 'package:e_learning/features/notifications/presentation/manager/notifications_cubit/notifications_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsCubit extends Cubit<NotificationsStates>{
  NotificationsCubit() : super(NotificationsInitialState());


}