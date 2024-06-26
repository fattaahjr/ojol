import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'home_page.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(),
          _buildRegistrationForm(context),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFf12711), Color(0xFFf5af19)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }

  Widget _buildRegistrationForm(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildLogo(),
                SizedBox(height: 20),
                Text(
                  'Registrasi',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                _buildNameField(),
                SizedBox(height: 20),
                _buildEmailField(),
                SizedBox(height: 20),
                _buildPhoneField(),
                SizedBox(height: 20),
                _buildPasswordField(),
                SizedBox(height: 20),
                _buildRegisterButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return CircleAvatar(
      radius: 50,
      backgroundImage: AssetImage('assets/logo.png'), // Ganti dengan path logo Anda
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      controller: namaController,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.person, color: Colors.white),
        labelText: 'Nama',
        labelStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.3),
      ),
      style: TextStyle(color: Colors.white),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Nama harus diisi';
        }
        return null;
      },
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: emailController,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email, color: Colors.white),
        labelText: 'Email',
        labelStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.3),
      ),
      style: TextStyle(color: Colors.white),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email harus diisi';
        }
        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return 'Masukkan email yang valid';
        }
        return null;
      },
    );
  }

  Widget _buildPhoneField() {
    return TextFormField(
      controller: phoneController,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.phone, color: Colors.white),
        labelText: 'Nomor Handphone',
        labelStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.3),
      ),
      style: TextStyle(color: Colors.white),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Nomor Handphone harus diisi';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: passwordController,
      obscureText: true,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock, color: Colors.white),
        labelText: 'Password',
        labelStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.3),
      ),
      style: TextStyle(color: Colors.white),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password harus diisi';
        }
        return null;
      },
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white, // Background color
        foregroundColor: Color(0xFFf12711), // Text color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        padding: EdgeInsets.symmetric(vertical: 15),
      ),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          _registerUser(context);
        }
      },
      child: Text(
        'Daftar',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

void _registerUser(BuildContext context) async {
  final String url = 'http://localhost/ojol/create.php';
  final response = await http.post(
    Uri.parse(url),
    body: {
      'nama': namaController.text,
      'email': emailController.text,
      'phone': phoneController.text,
      'password': passwordController.text,
    },
  );

  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  if (response.statusCode == 200) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  } else {
    // Tampilkan pesan error jika registrasi gagal
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Registrasi gagal. Silakan coba lagi.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
}
