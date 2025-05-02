import 'package:e_learning/core/methods/navigation.dart';
import 'package:e_learning/core/utils/app_assets.dart';
import 'package:e_learning/core/utils/app_styles.dart';
import 'package:e_learning/core/widgets/custom_circular_progress_indicator.dart';
import 'package:e_learning/core/widgets/empty_list_widget.dart';
import 'package:e_learning/features/chat/data/models/message_model/message_model.dart';
import 'package:e_learning/features/chat/presentation/manager/chat_cubit.dart';
import 'package:e_learning/features/chat/presentation/manager/chat_states.dart';
import 'package:e_learning/features/chat/presentation/views/widgets/message_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ConversationDetailsView extends StatelessWidget {
  final String instructorId;
  final String? instructorImage;
  final String? instructorName;


  const ConversationDetailsView({
    super.key,
    required this.instructorId,
    required this.instructorImage,
    required this.instructorName,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ChatCubit>();
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: (instructorImage != null && instructorImage != '')
                ? NetworkImage(instructorImage!)
                : AssetImage(AppAssets.userImage),
          ),
        ),
        title: Text(
          instructorName ?? 'name'.tr,
          style: AppStyles.style17,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back_sharp, color: Colors.black),
            onPressed: () {
              navigatePop(context: context);
            },
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatStates>(
              builder: (context, state) {
                if (state is GetMessagesLoadingState) {
                  return CustomCircularProgressIndicator();
                }
                return StreamBuilder(
                  stream: cubit.messagesStreamController.stream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CustomCircularProgressIndicator();
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return EmptyListWidget();
                    }
                    return ListView.builder(
                      controller: cubit.scrollController,
                      padding: EdgeInsets.all(16),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return MessageItem(message: snapshot.data![index]);
                      },
                    );
                  },
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: TextField(
                      controller: cubit.chatController,
                      decoration: InputDecoration(
                        hintText: "Type a message...",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: BlocBuilder<ChatCubit, ChatStates>(
                    builder: (context, state) {
                      return IconButton(
                        icon: Icon(Icons.send, color: Colors.white),
                        onPressed: () {
                          // print(instructorId);
                          cubit.sendMessage(to: instructorId);
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
