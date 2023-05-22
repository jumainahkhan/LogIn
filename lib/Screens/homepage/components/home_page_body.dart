import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:login/Screens/account/akunPage.dart';
import 'package:login/Screens/homepage/components/home_page_body.dart';
import 'package:login/Screens/article/artikelPage.dart';
import 'package:provider/provider.dart';
import 'package:login/models/artikelProvider.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({super.key});

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  final user = FirebaseAuth.instance.currentUser!;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.grey,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        flexibleSpace: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            //membuat radius border
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
            gradient: LinearGradient(
              //mengatur warna gradient
              colors: [Colors.green, Colors.greenAccent],
            ),
            boxShadow: [
              // memberikan shadow pada appbar
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
        ),
        title: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // memberi spasi antar widget
          children: [
            Icon(Icons.local_hospital_outlined, size: 50),
            Text('Home'),
            SizedBox(
              width: 250,
            ),
            GestureDetector(
              onTap: () {
                // Aksi yang ingin dilakukan saat ikon di klik
              },
              child: Icon(Icons.notifications_active_outlined),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.only(top: 12, bottom: 8, left: 6, right: 6),
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              image: DecorationImage(
                image: NetworkImage(
                  'https://akcdn.detik.net.id/visual/2021/09/07/ilustrasi-dokter_169.jpeg?w=650&q=90',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Text(
              'Selamat Datang',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Berita Terpopuler Seputar Kesehatan',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Hari Kesehatan Jiwa Sedunia',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 16),
                Image.network(
                  'https://asset.kompas.com/crops/b_vb9QCTepxDxDsxaIQ1P4brL5Y=/0x195:3812x2736/750x500/data/photo/2019/10/10/5d9e77702f4d8.jpg',
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Resep Makanan Sehat',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Cara Membuat Coto Makassar',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 16),
                Image.network(
                  'https://images.tokopedia.net/img/KRMmCm/2022/9/23/2067c6c6-82aa-46a1-8488-97a54c6b6ea4.jpg',
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tips Olahraga Sehat',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Gerakan Olahraga di Rumah untuk Pemula',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 16),
                Image.network(
                  'https://cms.sehatq.com/cdn-cgi/image/format=auto,width=1080,quality=90/public/img/article_img/9-gerakan-olahraga-di-rumah-untuk-pemula-dan-tips-memulainya-1641980138.jpg',
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ],
            ),
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
          currentIndex: 0,
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
