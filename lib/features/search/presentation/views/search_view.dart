import 'package:e_learning/core/utils/app_assets.dart';
import 'package:e_learning/core/widgets/custom_circular_progress_indicator.dart';
import 'package:e_learning/core/widgets/custom_divider.dart';
import 'package:e_learning/core/widgets/custom_text_form_field.dart';
import 'package:e_learning/core/widgets/shake_transition.dart';
import 'package:e_learning/features/home/presentation/views/widgets/course_item.dart';
import 'package:e_learning/features/search/presentation/manager/search_cubit.dart';
import 'package:e_learning/features/search/presentation/manager/search_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            BlocBuilder<SearchCubit, SearchStates>(
              builder: (context, state) {
                var cubit = context.read<SearchCubit>();
                return ShakeTransition(
                  offset: -100,
                  axis: Axis.vertical,
                  child: CustomTextFormField(
                    onFieldSubmitted: (_) {
                      cubit.search();
                    },
                    pIcon: Icons.search,
                    title: "search".tr,
                    controller: cubit.searchController,
                  ),
                );
              },
            ),
            SizedBox(
              height: 30,
            ),
            BlocBuilder<SearchCubit, SearchStates>(
              builder: (context, state) {
                var cubit = SearchCubit.get(context);
                var searchedCourses = cubit.searchResults;
                if (state is SearchLoadingState) {
                  return CustomCircularProgressIndicator();
                }
                if(searchedCourses.isEmpty){
                  return Lottie.asset(AppAssets.searchLottie, repeat: false);
                }
                return Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) => ShakeTransition(
                      duration: Duration(
                        seconds: 3 + index
                      ),
                      child: CourseItem(course: searchedCourses[index])
                    ),
                    separatorBuilder: (context, index) => CustomDivider(),
                    itemCount: searchedCourses.length,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
