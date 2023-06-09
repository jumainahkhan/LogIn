import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login/Screens/homepage/components/home_page_body.dart';

class AkunPage extends StatefulWidget {
  @override
  _AkunPageState createState() => _AkunPageState();
}

class _AkunPageState extends State<AkunPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late User user;
  String? username, email, mobileNumber, userType, collegeName;

  @override
  void initState() {
    super.initState();
    user = auth.currentUser!;
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    var docSnapshot = await firestore.collection("user").doc(user.uid).get();
    if (docSnapshot.exists) {
      var userData = docSnapshot.data();
      setState(() {
        username = userData!["name"];
        email = userData["email"];
        mobileNumber = userData["mobileNumber"];
        userType = userData["userType"];
        collegeName = userData["collegeName"];
      });
    }
  }

  Future<void> _updateUserProfile(String field, String value) async {
    await firestore.collection('user').doc(user.uid).update({field: value});
    _loadUserProfile();
  }

  void _showUpdateDialog(String field, String initialValue) {
    final _controller = TextEditingController(text: initialValue);
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Update $field'),
            content: TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: "Enter new $field"),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                child: Text('Update'),
                onPressed: () {
                  _updateUserProfile(field, _controller.text);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreenBody()),
            );
          },
        ),
        title: Text('Settings'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              MaterialPageRoute(builder: (context) => HomeScreenBody());
            },
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Username'),
            subtitle: Text(username ?? 'Loading...'),
            onTap: () => _showUpdateDialog('username', username ?? ''),
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('Email'),
            subtitle: Text(email ?? 'Loading...'),
            onTap: () => _showUpdateDialog('email', email ?? ''),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text('Mobile Number'),
            subtitle: Text(mobileNumber ?? 'Loading...'),
            onTap: () => _showUpdateDialog('mobileNumber', mobileNumber ?? ''),
          ),
          ListTile(
            leading: Icon(Icons.school),
            title: Text('College Name'),
            subtitle: Text(collegeName ?? 'Loading...'),
            onTap: () => _showUpdateDialog('collegeName', collegeName ?? ''),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('User Type'),
            subtitle: Text(userType ?? 'Loading...'),
            onTap: () => _showUpdateDialog('userType', userType ?? ''),
          ),
        ],
      ),
    );
  }
}
