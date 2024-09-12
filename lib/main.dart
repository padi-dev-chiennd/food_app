import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/root.dart';
import 'theme/color.dart';

// 1
Future<void> main() async {
  // 2
  WidgetsFlutterBinding.ensureInitialized();
  // 3
  final package =
  await MethodChannel('demo').invokeMethod<String>("getPackage");
  print(package);
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food App',
      theme: ThemeData(
        primaryColor: primary,
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const RootApp(),
    );
  }
}
