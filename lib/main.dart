import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_migaskita/core/di/injection.dart' as di;
import 'package:flutter_migaskita/firebase_options.dart';
import 'package:flutter_migaskita/presentation/providers/auth_provider.dart';
import 'package:flutter_migaskita/routes.dart';
import 'package:flutter_migaskita/core/constants/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => di.sl<AuthProvider>())],
      child: MaterialApp(
        theme: appTheme(),
        initialRoute: Routes.login,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
