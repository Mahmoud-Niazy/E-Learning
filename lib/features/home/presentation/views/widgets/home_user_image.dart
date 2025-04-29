import 'package:e_learning/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/app_assets.dart';

class HomeUserImage extends StatelessWidget{
  final num radius ;
  const HomeUserImage({super.key,this.radius = 20});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<HomeCubit>();
    return CircleAvatar(
        radius: radius.toDouble(),
        backgroundImage: cubit.user != null ?
        cubit.user!.image.isNotEmpty?
        NetworkImage(cubit.user!.image) :
        AssetImage(AppAssets.userImage) :
        AssetImage(AppAssets.userImage)
    );
  }
}