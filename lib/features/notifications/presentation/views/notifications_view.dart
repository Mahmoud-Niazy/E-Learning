import 'package:e_learning/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatelessWidget {
  final List<NotificationItem> notifications = [
    NotificationItem(
      icon: Icons.mail_outline,
      title: "New Message",
      subtitle: "You have received a new message.",
      timestamp: DateTime.now().subtract(Duration(minutes: 5)),
    ),
    NotificationItem(
      icon: Icons.shopping_cart_outlined,
      title: "Order Shipped",
      subtitle: "Your order #12345 has been shipped.",
      timestamp: DateTime.now().subtract(Duration(hours: 1)),
    ),
    NotificationItem(
      icon: Icons.payment_outlined,
      title: "Payment Received",
      subtitle: "You received a payment of \$250.",
      timestamp: DateTime.now().subtract(Duration(days: 1)),
    ),
  ];

  NotificationScreen({super.key});

  String formatTimestamp(DateTime time) {
    return DateFormat('MMM d, h:mm a').format(time);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Notifications",
          style: AppStyles.style17,
        ),
        elevation: 0,
        centerTitle: false,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Container(
            margin: EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: ListTile(
              contentPadding: EdgeInsets.all(16),
              leading: CircleAvatar(
                backgroundColor: Colors.indigo.shade50,
                child: Icon(notification.icon, color: Colors.indigo),
              ),
              title: Text(notification.title,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(notification.subtitle),
              trailing: Text(
                formatTimestamp(notification.timestamp),
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          );
        },
      ),
    );
  }
}

class NotificationItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final DateTime timestamp;

  NotificationItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.timestamp,
  });
}
