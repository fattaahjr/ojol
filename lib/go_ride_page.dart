import 'package:flutter/material.dart';

class GoRidePage extends StatefulWidget {
  @override
  _GoRidePageState createState() => _GoRidePageState();
}

class _GoRidePageState extends State<GoRidePage> {
  final _pickupController = TextEditingController();
  final _destinationController = TextEditingController();
  final _kelurahanController = TextEditingController();
  final _kecamatanController = TextEditingController();
  String _selectedService = 'GoRide';
  String _price = '';

  @override
  void dispose() {
    _pickupController.dispose();
    _destinationController.dispose();
    _kelurahanController.dispose();
    _kecamatanController.dispose();
    super.dispose();
  }

  void _calculatePrice() {
    final kelurahan = _kelurahanController.text;
    setState(() {
      // Logika perhitungan harga berdasarkan panjang string input kelurahan
      _price = (kelurahan.length * 500).toString(); // contoh perhitungan harga
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GoRide'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFf12711), Color(0xFFf5af19)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              Text(
                'Alamat',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _destinationController,
                decoration: InputDecoration(
                  hintText: 'Masukkan alamat',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Kelurahan',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _kelurahanController,
                decoration: InputDecoration(
                  hintText: 'Masukkan kelurahan',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (value) {
                  _calculatePrice();
                },
              ),
              SizedBox(height: 20),
              Text(
                'Kecamatan',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _kecamatanController,
                decoration: InputDecoration(
                  hintText: 'Masukkan kecamatan',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Harga: Rp $_price',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15), 
                  backgroundColor: Colors.orange,
                  textStyle: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  // Tambahkan logika pemesanan disini
                  _showOrderConfirmationDialog(context);
                },
                child: Text('Pesan Sekarang'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showOrderConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Pemesanan Berhasil'),
        content: Text('Pengemudi sedang menuju lokasi penjemputan Anda.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
