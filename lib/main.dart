import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:terminal_bimodal/src/app.dart';
import 'package:terminal_bimodal/src/screens/auth/auth.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Auth()),
      ],
      child: MyApp(),
    ),
  );
}
