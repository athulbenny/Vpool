import 'package:flutter/material.dart';

import '../../../models/user.dart';

class UserNotification extends StatefulWidget {
  const UserNotification({required this.user});
  final NewUser user;

  @override
  State<UserNotification> createState() => _UserNotificationState();
}

class _UserNotificationState extends State<UserNotification> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
