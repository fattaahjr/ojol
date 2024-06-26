import 'package:flutter/material.dart';
import 'profil_page.dart';
import 'go_ride_page.dart';
import 'chat_page.dart'; // Impor halaman chat

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildPromoBanner(),
            _buildNearbyServices(context),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            // Stay on Home
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatPage()), // Navigasi ke halaman chat
            );
          }
        },
      ),
    );
  }

  Widget _buildPromoBanner() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              'https://via.placeholder.com/600x200'), // Ganti dengan URL gambar promo Anda
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Text(
          'Promo Banner',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                offset: Offset(0, 1),
                blurRadius: 10.0,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNearbyServices(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Layanan di Sekitar',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          _buildServiceCard(context, 'GoRide', Icons.directions_car),
        ],
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context, String title, IconData icon) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Icon(icon, color: Colors.orange),
        title: Text(title),
        trailing: Icon(Icons.arrow_forward, color: Colors.orange),
        onTap: () {
          if (title == 'GoRide') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GoRidePage()),
            );
          }
          // Tambahkan logika untuk layanan lain jika ada
        },
      ),
    );
  }
}
