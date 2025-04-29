import 'package:flutter/material.dart';

import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/widgets/custom_icon_button.dart';

class SettingItem extends StatelessWidget {
  final String title;

  final void Function()? onPressed;

  const SettingItem({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        title,
        style: AppStyles.style17,
      ),
      trailing: CustomIconButton(
        onPressed: onPressed,
        icon: Icons.arrow_forward_ios,
      ),
    );
  }
}
