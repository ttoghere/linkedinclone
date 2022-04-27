import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:linkedinclone/persistent/persistent.dart';

import 'package:linkedinclone/widgets/bottom_nav_bar.dart';

class UploadJobNow extends StatefulWidget {
  const UploadJobNow({Key? key}) : super(key: key);

  @override
  State<UploadJobNow> createState() => _UploadJobNowState();
}

class _UploadJobNowState extends State<UploadJobNow> {
  TextEditingController _taskCategoryController = TextEditingController();
  TextEditingController _taskTitleController = TextEditingController();
  TextEditingController _taskDescriptionController = TextEditingController();
  TextEditingController _deadlineDateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime? picked;
  Timestamp? deadlineDateTimeStamp;
  bool _isLoading = false;
  @override
  void dispose() {
    _taskCategoryController.dispose();
    _taskDescriptionController.dispose();
    _taskTitleController.dispose();
    _deadlineDateController.dispose();
    super.dispose();
  }

  _pidkDateDialog() async {
    picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(
        Duration(days: 0),
      ),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _deadlineDateController.text =
            "${picked!.year} - ${picked!.month} - ${picked!.day}";
        deadlineDateTimeStamp = Timestamp.fromMicrosecondsSinceEpoch(
            picked!.microsecondsSinceEpoch);
      });
    }
  }

  _showTaskCategoriesDialog({required Size size}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        title: Text(
          "Job Category",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        content: Container(
          width: size.width * 0.9,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _taskCategoryController.text =
                        Persitent.taskCategoryList[index];
                  });
                  Navigator.of(context).pop();
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_right_outlined,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        Persitent.taskCategoryList[index],
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            itemCount: Persitent.taskCategoryList.length,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).canPop() ? Navigator.pop(context) : null;
            },
            child: Text(
              "Cancel",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: BottomNav(indexNum: 2),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(7),
          child: Card(
            color: Colors.white10,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "Please Fill All Fields",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TextFormFields extends StatelessWidget {
  final String valueKey;
  final TextEditingController controller;
  final bool enabled;
  final Function function;
  final int maxLength;
  const TextFormFields({
    Key? key,
    required this.valueKey,
    required this.controller,
    required this.enabled,
    required this.function,
    required this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: GestureDetector(
        onTap: () => function,
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return "Value is missing";
            }
            return null;
          },
          controller: controller,
          enabled: enabled,
          key: ValueKey(valueKey),
          style: TextStyle(color: Colors.white),
          maxLines: valueKey == "TaskDescription" ? 3 : 1,
          maxLength: maxLength,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white10),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white10),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red[900]!),
            ),
          ),
        ),
      ),
    );
  }
}

class TextTitles extends StatelessWidget {
  final String label;
  const TextTitles({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
