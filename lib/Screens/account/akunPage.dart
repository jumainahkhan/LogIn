import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    var docSnapshot = await firestore.collection("users").doc(user.uid).get();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back), // Add this line to add back button
            onPressed: () {
              Navigator.pop(context); // Add this line to make back button work
            },
          ),
          title: Text('Settings'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                // Put the function to handle settings here
              },
            )
          ],
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('user')
              .where('uid', isEqualTo: auth.currentUser!.uid)
              .snapshots()
              .map((querySnapshot) => querySnapshot.docs.first),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data!.data();
              var username = data['name'];
              var email = data['email'];
              var mobileNumber = data['mobileNumber'];
              var collegeName = data['collegeName'];
              var userType = data['userType'];

              return ListView(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.account_circle),
                    title: Text('Username'),
                    subtitle: Text(username ?? 'Loading...'),
                  ),
                  ListTile(
                    leading: Icon(Icons.email),
                    title: Text('Email'),
                    subtitle: Text(email ?? 'Loading...'),
                  ),
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: Text('Mobile Number'),
                    subtitle: Text(mobileNumber ?? 'Loading...'),
                  ),
                  ListTile(
                    leading: Icon(Icons.school),
                    title: Text('College Name'),
                    subtitle: Text(collegeName ?? 'Loading...'),
                  ),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('User Type'),
                    subtitle: Text(userType ?? 'Loading...'),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return CircularProgressIndicator();
            }
          },
        ));
  }
}
