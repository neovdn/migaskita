import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_migaskita/core/di/injection.dart' as di;
import 'package:flutter_migaskita/firebase_options.dart';
import 'package:flutter_migaskita/presentation/providers/auth_provider.dart';
import 'package:flutter_migaskita/presentation/providers/user_provider.dart';
import 'package:flutter_migaskita/core/constants/themes.dart';
import 'package:flutter_migaskita/routes.dart';
import 'package:flutter_migaskita/data/datasources/remote/user_remote_data_source.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<String> _initialRouteFuture;

  @override
  void initState() {
    super.initState();
    _initialRouteFuture = _determineInitialRoute();
  }

  Future<String> _determineInitialRoute() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isLoggedIn = prefs.getBool('is_logged_in') ?? false;
      final role = prefs.getString('user_role');
      final uid = firebase_auth.FirebaseAuth.instance.currentUser?.uid;

      debugPrint('isLoggedIn: $isLoggedIn');
      debugPrint('role: $role');
      debugPrint('uid: $uid');

      if (isLoggedIn && role != null && uid != null) {
        final dataSource = UserRemoteDataSourceImpl(FirebaseFirestore.instance);
        final userModel = await dataSource.getUserData(uid);

        if (userModel != null) {
          di.sl<UserProvider>().setUser(userModel.toEntity());
          return role == 'admin' ? Routes.adminHome : Routes.employeeHome;
        } else {
          debugPrint('⚠️ userModel is null');
        }
      }
    } catch (e) {
      debugPrint('🚨 Exception in _determineInitialRoute: $e');
    }

    return Routes.login;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => di.sl<AuthProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<UserProvider>()),
      ],
      child: FutureBuilder<String>(
        future: _initialRouteFuture,
        builder: (context, snapshot) {
          String initialRoute = Routes.login;

          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData &&
              snapshot.data != null &&
              snapshot.data!.isNotEmpty) {
            initialRoute = snapshot.data!;
          }

          return MaterialApp(
            theme: appTheme(),
            initialRoute: initialRoute,
            onGenerateRoute: Routes.generateRoute,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
