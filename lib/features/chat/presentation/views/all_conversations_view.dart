import 'package:e_learning/core/utils/app_styles.dart';
import 'package:e_learning/core/widgets/custom_circular_progress_indicator.dart';
import 'package:e_learning/core/widgets/empty_list_widget.dart';
import 'package:e_learning/features/chat/presentation/manager/chat_cubit.dart';
import 'package:e_learning/features/chat/presentation/manager/chat_states.dart';
import 'package:e_learning/features/chat/presentation/views/widgets/conversation_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';


class AllChatsView extends StatelessWidget {
  const AllChatsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ChatCubit>();
    cubit.getConversations();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'chats'.tr,
          style: AppStyles.style17,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocBuilder<ChatCubit, ChatStates>(
          builder: (context, state)  {
            if (state is GetConversationsLoadingState) {
              return CustomCircularProgressIndicator();
            }
            if(cubit.conversations.isEmpty){
              return EmptyListWidget();
            }
            return ListView.separated(
              itemBuilder: (context, index) {
                return ConversationItem(
                  conversation: cubit.conversations[index],
                );
              },
              separatorBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Divider(
                    color: Colors.black12,
                  ),
                );
              },
              itemCount: cubit.conversations.length,
            );
          },
        ),
      ),
    );
  }
}
