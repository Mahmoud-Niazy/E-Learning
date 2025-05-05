// import 'package:e_learning/features/chat/data/repos/chat_repo_imp.dart';
import 'package:e_learning/core/utils/app_assets.dart';
import 'package:e_learning/features/chat/presentation/manager/chat_cubit.dart';
import 'package:e_learning/features/home/data/models/get_courses_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../../core/methods/navigation.dart';
import '../../../../../core/scocket_io_services/socket_services.dart';
import '../../../../../core/utils/app_dimensions.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/widgets/custom_icon_button.dart';
import '../../../../chat/data/repos/chat_repo_imp.dart';
import '../../../../chat/presentation/views/conversation_details_view.dart';

class InstructorDetailsItem extends StatelessWidget {
  final CourseInstructorResponse instructor;
  // final String instructorId;

  const InstructorDetailsItem({
    super.key,
    required this.instructor,
    // required this.instructorId,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'instructor'.tr,
          style: AppStyles.style17,
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             
              Row(
                children: [
                  Container(
                    height: AppDimensions.screenHeight * .05,
                    width: AppDimensions.screenWidth * .2,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: (instructor.userProfileImage != null &&
                        instructor.userProfileImage != '')? NetworkImage(
                          instructor.userProfileImage!,
                        ) : AssetImage(AppAssets.userImage),
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Text(
                    instructor.name ?? '',
                    style: AppStyles.style13,
                  ),
                ],
              ),
            CustomIconButton(
              onPressed: () {
                // SocketService().init();
                navigate(
                    context: context,
                    screen: ConversationDetailsView(
                      // instructor: instructor,
                      instructorId: instructor.instructorId ?? '',
                      instructorImage: instructor.userProfileImage,
                      instructorName: instructor.name,
                    ));
                context.read<ChatCubit>().getMessages(instructor.instructorId ?? '');
                // ChatRepoImp(SocketService()).getMessagesOfConversation(instructor.instructorId ?? '');
              },
              icon: Icons.chat_outlined,
            ),
          ],
        ),
      ],
    );
  }
}
