import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class Editprofile extends StatefulWidget {
  const Editprofile({super.key});

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
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
            Icon(Icons.person, size: 40),
            Text('Edit Profile'),
            SizedBox(
              width: 150,
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsetsDirectional.only(
                  bottom: 0, end: 0, start: 0, top: 25),
              height: 115,
              width: 115,
              child: Stack(
                fit: StackFit.expand,
                children: const [
                  CircleAvatar(
                    maxRadius: 12,
                    backgroundColor: Colors.greenAccent,
                    backgroundImage: NetworkImage(
                        "data:image/jpeg;base64,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"),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: SizedBox(
                        height: 40,
                        width: 40,
                        child: Icon(
                          size: 40,
                          Icons.add_a_photo,
                          color: Colors.green,
                        )),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "username",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text("status",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
