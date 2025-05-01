import 'package:e_learning/core/cache_helper/cache_helper.dart';
import 'package:e_learning/core/methods/format_date.dart';
import 'package:e_learning/core/methods/navigation.dart';
import 'package:e_learning/features/chat/presentation/views/conversation_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_dimensions.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../data/models/conversation_model/conversation_model.dart';

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
    String lastMessage = conversation.lastMessage.text;
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
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 28.r,
                backgroundImage:
                    (getPersonImage() != null && getPersonImage() != '')
                        ? NetworkImage(getPersonImage()!)
                        : AssetImage(AppAssets.userImage),
              ),
              SizedBox(
                width: AppDimensions.screenWidth * .05,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    getPersonName(),
                    style: AppStyles.style13,
                  ),
                  Text(
                    getLastMessage(),
                    style: AppStyles.style11.copyWith(
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              Text(
                getMessageTime(),
                style: AppStyles.style11.copyWith(
                  color: Colors.black26,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
