import 'dart:async';
import 'package:dashky_finance/screen/profile2.dart';
import 'package:dashky_finance/screen/splash_view.dart';
import 'package:dashky_finance/screen/listnasabah.dart'; // Import ListNasabahPage
import 'package:dashky_finance/screen/laporanpage.dart'; // Import LaporanPage
import 'package:flutter/material.dart';

class Dashboard2Page extends StatefulWidget {
  const Dashboard2Page({super.key});

  @override
  _Dashboard2PageState createState() => _Dashboard2PageState();
}

class _Dashboard2PageState extends State<Dashboard2Page> {
  final PageController _pageController = PageController();
  int _bannerCurrentPage = 0;
  int _bottomNavCurrentIndex = 0;
  Timer? _timer;

  final List<String> _bannerImages = [
    'assets/iklan1.png',
    'assets/iklan2.png',
    'assets/iklan3.png',
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        if (_bannerCurrentPage < _bannerImages.length - 1) {
          _bannerCurrentPage++;
        } else {
          _bannerCurrentPage = 0;
        }
      });
      _pageController.animateToPage(
        _bannerCurrentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  // Update bottom navigation index when an item is clicked
  void _onBottomTabSelected(int index) {
    setState(() {
      _bottomNavCurrentIndex = index; // Update the bottom navigation index
    });

    // Navigate to Profile2Page when Profile tab is selected
    if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfileScreen2()),
      );
    }

    // Navigate to ListNasabahPage when List Nasabah tab is selected
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ListNasabahPage()), // Navigate to ListNasabahPage
      );
    }

    // Navigate to LaporanPage when Laporan tab is selected
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ListLaporanPage()), // Navigate to LaporanPage
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/logos.png',
          height: 40,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.article_rounded, color: Colors.black),
            onPressed: () {
              // Navigate to LaporanPage when icon is clicked
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListLaporanPage()), // Navigate to LaporanPage
              );
            },
          ),
        ],
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  height: 150,
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _bannerCurrentPage = index;
                      });
                    },
                    itemCount: _bannerImages.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: AssetImage(_bannerImages[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ),
                              Positioned(
                                bottom: 16,
                                left: 16,
                                right: 16,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Pinjaman cepat",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Proses cepat dan bunga rendah untuk memenuhi kebutuhan mendesak Anda.",
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_bannerImages.length, (index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                      width: _bannerCurrentPage == index ? 8 : 6,
                      height: _bannerCurrentPage == index ? 8 : 6,
                      decoration: BoxDecoration(
                        color: _bannerCurrentPage == index ? Colors.blue[900] : Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Berita Terkini",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                NewsCard(
                  image: 'assets/berita1.png',
                  title: "Simpanan Mudah dan Aman",
                  description: "Simpan uang Anda dengan akses yang mudah. Pilihan tepat untuk masa depan yang lebih cerah.",
                ),
                NewsCard(
                  image: 'assets/berita2.png',
                  title: "Simpanan Berjangka",
                  description: "Dapatkan keuntungan lebih dari simpanan berjangka dengan bunga yang kompetitif.",
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue[900],
        unselectedItemColor: Colors.grey,
        currentIndex: _bottomNavCurrentIndex,
        onTap: _onBottomTabSelected,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'List Nasabah',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Laporan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
        backgroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Rizky Eka Adinagoro"),
              accountEmail: Text("bossrizkyid@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/profile.jpeg'),
              ),
              decoration: BoxDecoration(
                color: Colors.blue[900],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.list_alt),
              title: Text('List Nasabah'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListNasabahPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.article),
              title: Text('Laporan'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListLaporanPage()), // Navigate to LaporanPage
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen2()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SplashView()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  NewsCard({required this.image, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                image,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
