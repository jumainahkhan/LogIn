import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/Screens/account/akunPage.dart';
import 'package:login/Screens/article/addArtikelPage.dart';
import 'package:login/Screens/article/detailArtikelPage.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({Key? key}) : super(key: key);

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  String _searchKeyword = '';
  final TextEditingController _searchController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late User user;
  String? name, userType, imageUrl;

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
        name = userData!["name"];
        userType = userData["userType"];
        imageUrl = userData["imageUrl"];
      });
    }
  }

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
            Icon(Icons.tips_and_updates_outlined, size: 40),
            Text('Jelajah'),
            SizedBox(
              width: 100,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddArticlePage()),
                );
              },
              child: Icon(Icons.post_add_outlined),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Menambahkan carousel di sini
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('koleksi').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                return CarouselSlider(
                  options: CarouselOptions(
                    aspectRatio: 1.5,
                    autoPlay: true,
                  ),
                  items: snapshot.data!.docs.map((doc) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          child: Card(
                            child: Column(
                              children: [
                                Image.network(doc['imageUrl']),
                                Text(doc['judul']),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                );
              },
            ),
            TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchKeyword = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Search',
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Artikel Terkini 🔥',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('koleksi')
                    .where('judul', isGreaterThanOrEqualTo: _searchKeyword)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Terjadi kesalahan');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  // Mengambil data artikel dari snapshot
                  List<DocumentSnapshot> articles = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      // Mengambil data judul dan imageUrl dari artikel
                      String judul = articles[index]['judul'];
                      String imageUrl = articles[index]['imageUrl'];
                      print(imageUrl);

                      return ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailArtikelPage(
                                id: articles[index].id,
                              ),
                            ),
                          );
                        },
                        leading: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Text(judul),
                        subtitle: Text(
                            'Author: '), // masukin nama author yang buat artikel nya
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(name ?? 'Loading...'),
              accountEmail: Text(userType ?? 'Loading...'),
              currentAccountPicture: imageUrl != null
                  ? CircleAvatar(backgroundImage: NetworkImage(imageUrl!))
                  : CircleAvatar(backgroundColor: Colors.orange),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreenBody()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.bookmark),
              title: Text('Bookmark'),
              onTap: () {
                //fungsi bookmark buat nge save artikel yang udh di bookmark
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(
                  'Settings'), //masuk ke halaman setting profile buat edit data user
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => AkunPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
              onTap: () {
                FirebaseAuth.instance.signOut();
                //fungsi log out firebase
              },
            ),
          ],
        ),
      ),
    );
  }
}
