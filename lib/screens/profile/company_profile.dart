import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = "/ps";
  final String userId;
  const ProfileScreen({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
