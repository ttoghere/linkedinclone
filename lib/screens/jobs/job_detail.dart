import 'package:flutter/material.dart';

class JobDetails extends StatefulWidget {
  JobDetails({
    Key? key,
    required this.uploadedBy,
    required this.taskId,
  }) : super(key: key);
  final String uploadedBy;
  final String taskId;

  @override
  State<JobDetails> createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
