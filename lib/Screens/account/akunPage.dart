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

  void _showEditDialog(String field) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String? value = '';

        return AlertDialog(
          title: Text('Edit $field'),
          content: TextField(
            onChanged: (newValue) {
              value = newValue;
            },
            decoration: InputDecoration(
              labelText: field,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () async {
                if (value != null && value!.isNotEmpty) {
                  try {
                    await firestore
                        .collection('user')
                        .doc(user.uid)
                        .update({field: value});
                    setState(() {
                      switch (field) {
                        case 'name':
                          username = value;
                          break;
                        case 'Email':
                          email = value;
                          break;
                        case 'mobileNumber':
                          mobileNumber = value;
                          break;
                        case 'collegeName':
                          collegeName = value;
                          break;
                        case 'userType':
                          userType = value;
                          break;
                        default:
                          break;
                      }
                    });
                    Navigator.pop(context);
                  } catch (e) {
                    print('Error updating user data: $e');
                  }
                }
              },
            ),
          ],
        );
      },
    );
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
                  onTap: () => _showEditDialog('name'),
                ),
                ListTile(
                  leading: Icon(Icons.email),
                  title: Text('Email'),
                  subtitle: Text(email ?? 'Loading...'),
                  onTap: () => _showEditDialog('email'),
                ),
                ListTile(
                  leading: Icon(Icons.phone),
                  title: Text('Mobile Number'),
                  subtitle: Text(mobileNumber ?? 'Loading...'),
                  onTap: () => _showEditDialog('mobileNumber'),
                ),
                ListTile(
                  leading: Icon(Icons.school),
                  title: Text('College Name'),
                  subtitle: Text(collegeName ?? 'Loading...'),
                  onTap: () => _showEditDialog('collegeName'),
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('User Type'),
                  subtitle: Text(userType ?? 'Loading...'),
                  onTap: () => _showEditDialog('userType'),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
