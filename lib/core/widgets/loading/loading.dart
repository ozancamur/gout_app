import 'package:flutter/material.dart';
import 'package:gout_app/core/services/constant/color/color_constants.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(
        valueColor: AlwaysStoppedAnimation<Color>(ColorConstants.goutPurple),
        backgroundColor: Colors.white,
      ),
    );
  }
}