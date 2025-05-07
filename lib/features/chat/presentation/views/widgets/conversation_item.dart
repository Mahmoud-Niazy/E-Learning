import 'package:e_learning/core/cache_helper/cache_helper.dart';
import 'package:e_learning/core/methods/format_date.dart';
import 'package:e_learning/core/methods/navigation.dart';
import 'package:e_learning/features/chat/presentation/views/conversation_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_dimensions.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../data/models/conversation_model/conversation_model.dart';
import '../../manager/chat_cubit.dart';

class ConversationItem extends StatelessWidget {
  final ConversationModel conversation;

  const ConversationItem({
    super.key,
    required this.conversation,
  });

  String getPersonName() {
    for(var person in conversation.participants){
      if(person.id != CacheHelper.userId){
        String name = conversation.participants[1].name;
        return name;
      }
    }
    return '';
  }

  String? getPersonImage() {
    for(var person in conversation.participants){
      if(person.id != CacheHelper.userId){
        String image = conversation.participants[1].userProfileImage;
        return image;
      }
    }
    return null;
  }

  String getPersonId() {
    for(var person in conversation.participants){
      if(person.id != CacheHelper.userId){
        String id = conversation.participants[1].id;
        return id;
      }
    }
    return '';
  }

  String getMessageTime() {
    String time = conversation.createdAt;
    return formatDateWithTime(time);
  }

  String getLastMessage() {
    String lastMessage = conversation.lastMessage?.text ?? '';
    return lastMessage;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigate(
          context: context,
          screen: ConversationDetailsView(
            instructorName: getPersonName(),
            instructorImage: getPersonImage(),
            instructorId: getPersonId(),
          ),
        );
        context.read<ChatCubit>().getMessages(getPersonId());

      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25.r,
                  backgroundImage:
                      (getPersonImage() != null && getPersonImage() != '')
                          ? NetworkImage(getPersonImage()!)
                          : AssetImage(AppAssets.userImage),
                ),
                SizedBox(
                  width: AppDimensions.screenWidth * .05,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        getPersonName(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.style13,
                      ),
                      Text(
                        getLastMessage(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.style11.copyWith(
                          color:CacheHelper.isDarkMode ? Colors.white : Colors.black45,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Text(
                getMessageTime(),
                style: AppStyles.style11.copyWith(
                  color:CacheHelper.isDarkMode ? Colors.white : Colors.black26,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              if(
              conversation.lastMessage?.seen == false
              &&
              CacheHelper.userId != conversation.lastMessage?.from
              )
              Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
