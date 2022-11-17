import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ssd_secure_app/Providers/FileProvider.dart';
import 'package:ssd_secure_app/Providers/MessageProvider.dart';
import 'package:ssd_secure_app/Screens/Login.dart';
import 'package:ssd_secure_app/routes/screen_routes.dart';

import 'Providers/AuthProvider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => MessageProvider()),
        ChangeNotifierProvider(create: (_) => FileProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SSD Assingment',
      home: Login(),
      onGenerateRoute: ScreenRoutes.generateRoute,
    );
  }
}
