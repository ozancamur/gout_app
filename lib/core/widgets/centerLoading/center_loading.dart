 import 'package:flutter/material.dart';

buildCenterLoading() {
    return const Center(
      child: CircularProgressIndicator.adaptive(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
        backgroundColor: Colors.grey,
      ),
    );
  }