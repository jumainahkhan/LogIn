import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login/Screens/account/akunPage.dart';
import 'package:login/Screens/account/editProfilPage.dart';
import 'package:login/Screens/homepage/components/home_page_body.dart';
import 'package:login/Screens/article/artikelPage.dart';
import 'package:provider/provider.dart';
import 'package:login/models/artikelProvider.dart';

class AkunPage extends StatelessWidget {
  const AkunPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        flexibleSpace: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12)),
            gradient:
                LinearGradient(colors: [Colors.green, Colors.greenAccent]),
          ),
        ),
        title: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // memberi spasi antar widget
          children: [
            Icon(Icons.settings_outlined, size: 40),
            Text('Settings'),
            SizedBox(
              width: 250,
            ),
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 20),
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Edit Profile'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Editprofile()));
              // showDialog(
              //   context: context,
              //   builder: (BuildContext context) {
              //     return AlertDialog(
              //       title: Text('Edit Profile'),
              //       content: Text('Here you can change your app settings.'),
              //       actions: <Widget>[
              //         TextButton(
              //           child: Text('CANCEL'),
              //           onPressed: () {
              //             Navigator.of(context).pop();
              //           },
              //         ),
              //         TextButton(
              //           child: Text('OK'),
              //           onPressed: () {
              //             // Perform the desired action on OK button press
              //             Navigator.of(context).pop();
              //           },
              //         ),
              //       ],
              //     );
              //   },
              // );
            },
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text('Language'),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Language'),
                    content: Text('Here you can change your app settings.'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('CANCEL'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('OK'),
                        onPressed: () {
                          // Perform the desired action on OK button press
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.bookmark),
            title: Text('Bookmark'),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Bookmark'),
                    content: Text('Here you can change your app settings.'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('CANCEL'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('OK'),
                        onPressed: () {
                          // Perform the desired action on OK button press
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green, Colors.greenAccent.shade400],
          ),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(12),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          unselectedItemColor: Colors.greenAccent,
          backgroundColor: Colors.transparent,
          selectedItemColor: Colors.white,
          currentIndex: 2,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.tips_and_updates),
              label: 'Jelajah',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          onTap: (index) {
            if (index == 0) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreenBody()),
              );
            } else if (index == 1) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ArtikelPage()),
              );
            } else if (index == 2) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AkunPage()),
              );
            }
          },
        ),
      ),
    );
  }
}
