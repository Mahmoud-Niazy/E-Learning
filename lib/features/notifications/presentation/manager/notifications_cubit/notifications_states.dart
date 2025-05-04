abstract class NotificationsStates {}

class NotificationsInitialState extends NotificationsStates{}

class GetAllNotificationsLoadingState extends NotificationsStates{}
class GetAllNotificationsSuccessState extends NotificationsStates{}
class GetAllNotificationsErrorState extends NotificationsStates{
  final String error;
  GetAllNotificationsErrorState(this.error);
}