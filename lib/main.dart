import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tuduu/router/navigation_helper.dart';
import 'util.dart';
import 'theme.dart';

void main() async {
  NavigationHelper.instance;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Tuduu());
}

class Tuduu extends StatelessWidget {
  const Tuduu({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    TextTheme textTheme = createTextTheme(context, "Nunito Sans", "Amiko");
    MaterialTheme theme = MaterialTheme(textTheme);

    return MaterialApp.router(
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      routerConfig: NavigationHelper.router,
    );
  }
}