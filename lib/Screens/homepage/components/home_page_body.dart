import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/Screens/account/akunPage.dart';
import 'package:login/Screens/article/addArtikelPage.dart';
import 'package:login/Screens/article/detailArtikelPage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'package:login/Screens/login/login.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({Key? key}) : super(key: key);

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class UserProfileDrawerHeader extends StatefulWidget {
  @override
  _UserProfileDrawerHeaderState createState() =>
      _UserProfileDrawerHeaderState();
}

class _UserProfileDrawerHeaderState extends State<UserProfileDrawerHeader> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('user')
          .where('uid', isEqualTo: auth.currentUser!.uid)
          .snapshots()
          .map((querySnapshot) => querySnapshot.docs.first),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return UserAccountsDrawerHeader(
            accountName: Text('Loading...'),
            accountEmail: Text('Loading...'),
            currentAccountPicture: CircleAvatar(backgroundColor: Colors.orange),
          );
        }

        if (snapshot.hasError) {
          return UserAccountsDrawerHeader(
            accountName: Text('Error'),
            accountEmail: Text('Error'),
            currentAccountPicture: CircleAvatar(backgroundColor: Colors.red),
          );
        }

        if (snapshot.hasData) {
          var data = snapshot.data!.data();
          var username = data['name'];
          var email = data['email'];
          var userType = data['userType'];
          var imageUrl = data['imageUrl'];

          return UserAccountsDrawerHeader(
            accountName: Text(username),
            accountEmail: Text(userType),
            currentAccountPicture: imageUrl != null
                ? CircleAvatar(backgroundImage: NetworkImage(imageUrl))
                : CircleAvatar(backgroundColor: Colors.orange),
          );
        }

        return UserAccountsDrawerHeader(
          accountName: Text('No data'),
          accountEmail: Text('No data'),
          currentAccountPicture: CircleAvatar(backgroundColor: Colors.orange),
        );
      },
    );
  }
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  String _searchKeyword = '';
  final TextEditingController _searchController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

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
                      Timestamp timestamp = articles[index]['date'];
                      DateTime date = timestamp.toDate();
                      String formattedDate =
                          DateFormat('dd MMMM yyyy').format(date);

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
                            'Tanggal rilis: $formattedDate'), // masukan nama author yang buat artikel nya
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
            // Menampilkan header drawer yang berisi informasi profil pengguna
            UserProfileDrawerHeader(),

            // Menu Home
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

            // Menu Profile
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AkunPage()),
                );
              },
            ),

            // Menu Logout
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                // Setelah berhasil sign out, arahkan pengguna ke halaman login
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
