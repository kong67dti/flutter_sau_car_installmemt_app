import 'package:flutter/material.dart';
import 'package:flutter_sau_car_installmemt_app/views/calculator.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(FlutterSauCarInstallmentApp());
}

class FlutterSauCarInstallmentApp extends StatefulWidget {
  const FlutterSauCarInstallmentApp({super.key});

  @override
  State<FlutterSauCarInstallmentApp> createState() =>
      _FlutterSauCarInstallmentAppState();
}

class _FlutterSauCarInstallmentAppState
    extends State<FlutterSauCarInstallmentApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
    );
  }
}
