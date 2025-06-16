import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_button.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool _isValidPhone(String phone) {
    return RegExp(r'^\d{10,15}$').hasMatch(phone);
  }

  Future<void> _handleSignUp() async {
    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // Validasi kosong
    if (name.isEmpty || phone.isEmpty || email.isEmpty || password.isEmpty) {
      _showSnackBar('Semua field harus diisi');
      return;
    }

    // Validasi email
    if (!_isValidEmail(email)) {
      _showSnackBar('Email tidak valid');
      return;
    }

    // Validasi nomor telepon
    if (!_isValidPhone(phone)) {
      _showSnackBar('Nomor telepon tidak valid (10-15 digit angka)');
      return;
    }

    // Validasi panjang password
    if (password.length < 8) {
      _showSnackBar('Password harus minimal 8 karakter');
      return;
    }

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    await authProvider.signUpUser(
      email: email,
      password: password,
      name: name,
      phone: phone,
    );

    if (authProvider.user != null) {
      _showSnackBar('Pendaftaran berhasil! Silakan login.');

      // Tunggu 2 detik, lalu navigasi ke login
      await Future.delayed(Duration(seconds: 2));
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      _showSnackBar('Pendaftaran gagal. Coba lagi.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/signn.png', height: 180),
                      Text(
                        'Sign Up',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      CustomTextField(
                        label: 'Enter Name',
                        controller: _nameController,
                      ),
                      CustomTextField(
                        label: 'Phone Number',
                        controller: _phoneController,
                      ),
                      CustomTextField(
                        label: 'Enter Email',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      CustomTextField(
                        label: 'Enter Password',
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      CustomButton(text: 'Daftar', onPressed: _handleSignUp),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
