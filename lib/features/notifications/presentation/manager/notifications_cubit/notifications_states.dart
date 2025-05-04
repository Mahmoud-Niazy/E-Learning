abstract class NotificationsStates {}

class NotificationsInitialState extends NotificationsStates{}

class GetAllNotificationsLoadingState extends NotificationsStates{}
class GetAllNotificationsSuccessState extends NotificationsStates{}
class GetAllNotificationsErrorState extends NotificationsStates{
  final String error;
  GetAllNotificationsErrorState(this.error);
}

class MakeAllNotificationsSeenLoadingState extends NotificationsStates{}
class MakeAllNotificationsSeenSuccessState extends NotificationsStates{}
class MakeAllNotificationsSeenErrorState extends NotificationsStates{
  final String error;
  MakeAllNotificationsSeenErrorState(this.error);
}

class MakeNotificationSeenLoadingState extends NotificationsStates{}
class MakeNotificationSeenSuccessState extends NotificationsStates{}
class MakeNotificationSeenErrorState extends NotificationsStates{
  final String error;
  MakeNotificationSeenErrorState(this.error);
}

class ReceiveRealTimeNotificationsLoadingState extends NotificationsStates{}
class ReceiveRealTimeNotificationsSuccessState extends NotificationsStates{}
class ReceiveRealTimeNotificationsErrorState extends NotificationsStates{
  final String error;
  ReceiveRealTimeNotificationsErrorState(this.error);
}