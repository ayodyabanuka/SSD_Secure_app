import 'package:flutter/material.dart';
import 'package:ssd_secure_app/Screens/AddUser.dart';
import 'package:ssd_secure_app/Screens/EditProfile.dart';
import 'package:ssd_secure_app/Screens/Files.dart';
import 'package:ssd_secure_app/Screens/Home.dart';
import 'package:ssd_secure_app/Screens/Messagers.dart';
import 'package:ssd_secure_app/Screens/Profile.dart';

class ScreenRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/HomeScreen":
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => Home(),
          settings: settings,
          transitionsBuilder: (_, opacity, __, child) => FadeTransition(
            opacity: opacity,
            child: child,
          ),
        );
      case "/AddUserScreen":
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => AddUser(),
          settings: settings,
          transitionsBuilder: (_, opacity, __, child) => FadeTransition(
            opacity: opacity,
            child: child,
          ),
        );
      case "/EditProfileScreen":
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => EditProfile(),
          settings: settings,
          transitionsBuilder: (_, opacity, __, child) => FadeTransition(
            opacity: opacity,
            child: child,
          ),
        );
      case "/FilesScreen":
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => Files(),
          settings: settings,
          transitionsBuilder: (_, opacity, __, child) => FadeTransition(
            opacity: opacity,
            child: child,
          ),
        );
      case "/MessageScreen":
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => Messages(),
          settings: settings,
          transitionsBuilder: (_, opacity, __, child) => FadeTransition(
            opacity: opacity,
            child: child,
          ),
        );
      case "/ProfileScreen":
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => Profile(),
          settings: settings,
          transitionsBuilder: (_, opacity, __, child) => FadeTransition(
            opacity: opacity,
            child: child,
          ),
        );
      default:
        return null;
    }
  }
}
