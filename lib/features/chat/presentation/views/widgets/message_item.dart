import 'package:e_learning/core/cache_helper/cache_helper.dart';
import 'package:e_learning/features/chat/data/models/message_model/message_model.dart';
import 'package:flutter/material.dart';

class MessageItem extends StatelessWidget {
  final MessageModel message;

  const MessageItem({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    bool isMe = (message.from == CacheHelper.userId);
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        decoration: BoxDecoration(
          color: isMe ? Colors.blue[200] : Colors.grey[300],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomLeft:
                isMe ? Radius.circular(12) : Radius.circular(0),
            bottomRight:
                isMe ? Radius.circular(0) : Radius.circular(12),
          ),
        ),
        child: Text(
          message.text,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
