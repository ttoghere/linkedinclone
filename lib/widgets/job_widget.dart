import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:linkedinclone/consts/global_methods.dart';
import 'package:linkedinclone/screens/jobs/job_detail.dart';
import 'package:uuid/uuid.dart';

class JobWidget extends StatefulWidget {
  JobWidget({
    Key? key,
    required this.taskTitle,
    required this.taskDescription,
    required this.taskId,
    required this.uploadedBy,
    required this.userImage,
    required this.name,
    required this.recruiment,
    required this.email,
    required this.location,
  }) : super(key: key);
  final String taskTitle;
  final String taskDescription;
  final String taskId;
  final String uploadedBy;
  final String userImage;
  final String name;
  final bool recruiment;
  final String email;
  final String location;

  @override
  State<JobWidget> createState() => _JobWidgetState();
}

class _JobWidgetState extends State<JobWidget> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  _deleteDialog() {
    User? user = _auth.currentUser;
    final _uid = user!.uid;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actions: [
          TextButton(
            onPressed: () async {
              try {
                if (widget.uploadedBy == _uid) {
                  await FirebaseFirestore.instance
                      .collection("tasks")
                      .doc(widget.taskId)
                      .delete();
                  await Fluttertoast.showToast(
                    msg: "Task has been deleted",
                    toastLength: Toast.LENGTH_LONG,
                    backgroundColor: Colors.grey,
                    fontSize: 18,
                  );
                  Navigator.of(context).canPop()
                      ? Navigator.of(context).pop()
                      : null;
                } else {
                  GlobalMethod.showErrorDialog(
                    error: "You can't perform this action",
                    ctx: context,
                  );
                }
              } catch (e) {
                GlobalMethod.showErrorDialog(
                  error: "You can't perform this action",
                  ctx: context,
                );
              } finally {}
            },
            child: Row(
              children: [
                Icon(
                  Icons.delete,
                  color: Colors.red[900],
                ),
                Text(
                  "Delete",
                  style: TextStyle(color: Colors.red[900]),
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white10,
      elevation: 9,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: ListTile(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => JobDetails(
              uploadedBy: widget.uploadedBy,
              taskId: widget.taskId,
            ),
          ),
        ),
        onLongPress: _deleteDialog,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: Container(
          padding: EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(width: 1),
            ),
          ),
          child: Image.network(widget.userImage),
        ),
        title: Text(
          widget.taskTitle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              widget.taskDescription,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(
              height: 8,
            ),
          ],
        ),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          size: 30,
          color: Colors.grey,
        ),
      ),
    );
  }
}
