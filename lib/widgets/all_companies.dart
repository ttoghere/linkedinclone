import 'package:flutter/material.dart';
import 'package:linkedinclone/screens/profile/company_profile.dart';
import 'package:url_launcher/url_launcher.dart';

class AllWorkersWidget extends StatefulWidget {
  AllWorkersWidget({
    Key? key,
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.pNumber,
    required this.userImageUrl,
  }) : super(key: key);
  final String userId;
  final String userName;
  final String userEmail;
  final String pNumber;
  final String userImageUrl;

  @override
  State<AllWorkersWidget> createState() => _AllWorkersWidgetState();
}

class _AllWorkersWidgetState extends State<AllWorkersWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      color: Colors.white10,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProfileScreen(userId: widget.userId),
          ));
        },
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: Container(
          padding: EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(width: 1),
            ),
          ),
          child: Image.network(widget.userImageUrl == null
              ? "https://images.unsplash.com/photo-1519755898819-cef8c3021d6f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8YW5vbnltb3VzJTIwbWFufGVufDB8fDB8fA%3D%3D&w=1000&q=80"
              : widget.userImageUrl),
        ),
        title: Text(
          widget.userName,
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
              "Visit Profile",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.grey,
              ),
            )
          ],
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.mail_outline,
            size: 30,
          ),
          color: Colors.grey,
          onPressed: _mailTo,
        ),
      ),
    );
  }

  void _mailTo() async {
    var mailUrl = Uri.parse("mailto: ${widget.userEmail}");
    print("widget.userEmail ${widget.userEmail}");
    if (await canLaunchUrl(mailUrl)) {
      await launchUrl(mailUrl).catchError((error) {
        print(error);
      });
    } else {
      print("Error");
    }
  }
}
