import 'package:flutter/material.dart';
import 'home_page.dart';
import 'register_page.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _loginToServer(BuildContext context) async {
    final String url = 'http://localhost/ojol/login.php'; // Ganti dengan alamat server Anda
    final response = await http.post(
      Uri.parse(url),
      body: {
        'email': emailController.text,
        'password': passwordController.text,
      },
    );

    if (response.statusCode == 200) {
      // Tangani respons dari server di sini
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      // Navigasi ke halaman beranda (home page) jika login berhasil
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      // Tangani kesalahan jika koneksi gagal
      print('Error: ${response.reasonPhrase}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(),
          _buildLoginForm(context),
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

  Widget _buildLoginForm(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildLogo(),
              SizedBox(height: 20),
              Text(
                'Halaman Login',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              _buildEmailField(),
              SizedBox(height: 20),
              _buildPasswordField(),
              SizedBox(height: 20),
              _buildForgotPasswordButton(),
              SizedBox(height: 20),
              _buildLoginButton(context),
              SizedBox(height: 20),
              _buildRegisterButton(context),
            ],
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
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: passwordController,
      obscureText: _isObscure,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock, color: Colors.white),
        labelText: 'Password',
        labelStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.3),
        suffixIcon: IconButton(
          icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off, color: Colors.white),
          onPressed: () {
            setState(() {
              _isObscure = !_isObscure;
            });
          },
        ),
      ),
      style: TextStyle(color: Colors.white),
    );
  }

  Widget _buildForgotPasswordButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          // Lakukan tindakan ketika tombol "Lupa Kata Sandi?" ditekan
        },
        child: Text(
          'Lupa Kata Sandi?',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Color(0xFFf12711), backgroundColor: Colors.white, // Text color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        padding: EdgeInsets.symmetric(vertical: 15),
      ),
      onPressed: () {
        // Panggil fungsi untuk login pengguna
        _loginToServer(context);
      },
      child: Text(
        'Login',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        // Navigasi ke halaman register
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegisterPage()),
        );
      },
      child: Text(
        'Pengguna Baru? Daftar Disini',
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
    );
  }
}
