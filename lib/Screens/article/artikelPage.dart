import 'package:flutter/material.dart';
import 'package:login/Screens/account/akunPage.dart';
import 'package:login/Screens/homepage/components/home_page_body.dart';
import 'package:login/Screens/article/artikelPage.dart';
import 'package:provider/provider.dart';
import 'package:login/models/artikelProvider.dart';

import 'addArtikelPage.dart';
import 'detailArtikelPage.dart';

class ArtikelPage extends StatefulWidget {
  const ArtikelPage({Key? key}) : super(key: key);

  @override
  State<ArtikelPage> createState() => _ArtikelPageState();
}

class _ArtikelPageState extends State<ArtikelPage> {
  void initState() {
    super.initState();
    Provider.of<artikel>(context, listen: false).getAllArticle();
  }

  @override
  Widget build(BuildContext context) {
    final article = Provider.of<artikel>(context);
    final allArticle = article.allArticle;
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
              width: 220,
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
              child: Text(
                'Artikel Dibuat 🔥',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8),
            Container(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: allArticle.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Text(
                          allArticle[index].title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 10),
                        ),
                        Container(
                          width: 150,
                          height: 150,
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                allArticle[index].image,
                              ),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[300],
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailArtikelPage(
                                          id: allArticle[index].id,
                                        )),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                )),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
              child: Text(
                'Berita Seputar Kesehatan',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8),
            Container(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    width: 200,
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://web.karokab.go.id/images/thumbnails/images/2020/GaleriFoto/TanggapanMasyarakatKaro_1-fill-214x214.jpg',
                        ),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300],
                    ),
                  ),
                  Container(
                    width: 200,
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://web.kominfo.go.id/sites/default/files/Infografis%20RPJMN%20Final-35(1).jpg',
                        ),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300],
                    ),
                  ),
                  Container(
                    width: 200,
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRGq6NMzXL1wFliWBoAtstFkVjVOxV6fAhWZg&usqp=CAU',
                        ),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
              child: Text(
                'Tips Makanan Sehat',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8),
            Container(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    width: 200,
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://storage.aido.id/articles/July2022/9sfzw7edh482w8tg02ir.webp',
                        ),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300],
                    ),
                  ),
                  Container(
                    width: 200,
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://res.cloudinary.com/dk0z4ums3/image/upload/v1594622094/attached_image/ini-makanan-sehat-yang-perlu-dikonsumsi-setiap-hari-0-alodokter.jpg',
                        ),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300],
                    ),
                  ),
                  Container(
                    width: 200,
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://cdn.idntimes.com/content-images/post/20191217/hanhanny-60841941-1963894330381469-3916423929361306297-n-c5f0d13e8dbd0a9f273e96f152872cbc_600x400.jpg',
                        ),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
              child: Text(
                'Trick Olahraga Teratur',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8),
            Container(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    width: 200,
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://img-cdn.medkomtek.com/P5cMHVk2qKUlv_CTwQo1Z_eAjkw=/730x411/smart/filters:quality(75):strip_icc():format(webp)/article/O-Aq3WlaQkGVu0YUjujeQ/original/1666928242-Manfaat%20Olahraga%20bagi%20Kesehatan%20Mental.jpg',
                        ),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300],
                    ),
                  ),
                  Container(
                    width: 200,
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://res.cloudinary.com/dk0z4ums3/image/upload/v1649035492/attached_image/yuk-ketahui-manfaat-olahraga-yoga-saat-puasa-0-alodokter.jpg',
                        ),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300],
                    ),
                  ),
                  // Container(
                  //   width: 200,
                  //   margin: EdgeInsets.all(8),
                  //   decoration: BoxDecoration(
                  //     image: DecorationImage(
                  //       image: NetworkImage(
                  //         'https://cdns.klimg.com/dream.co.id/resources/news/2021/05/03/167083/664xauto-berenang-saat-pandemi-boleh-atau-tidak-210503v.jpg',
                  //       ),
                  //       fit: BoxFit.cover,
                  //     ),
                  //     borderRadius: BorderRadius.circular(10),
                  //     color: Colors.grey[300],
                  //   ),
                  // ),
                ],
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
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
          backgroundColor: Colors.transparent,
          unselectedItemColor: Colors.greenAccent,
          selectedItemColor: Colors.white,
          currentIndex: 1,
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
