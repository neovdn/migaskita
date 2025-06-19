import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter_migaskita/presentation/providers/user_provider.dart';
import 'package:flutter_migaskita/data/datasources/remote/user_remote_data_source.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InitialPage extends StatefulWidget {
  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final userDataSource = UserRemoteDataSourceImpl(_firestore);
      final userModel = await userDataSource.getUserData(currentUser.uid);

      if (userModel != null) {
        userProvider.setUser(userModel.toEntity());

        if (userModel.role == 'admin') {
          Navigator.pushReplacementNamed(context, '/admin-home');
        } else {
          Navigator.pushReplacementNamed(context, '/employee-home');
        }
      } else {
        await _auth.signOut();
        Navigator.pushReplacementNamed(context, '/login');
      }
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
