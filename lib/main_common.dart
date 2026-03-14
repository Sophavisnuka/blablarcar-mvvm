import 'package:flutter/material.dart';

import 'data/repositories/location/location_repository.dart';
import 'ui/screens/home/home_screen.dart';
import 'ui/theme/theme.dart';

// Global repository instance accessible throughout the app
late LocationRepository locationRepository;

void mainCommon({required LocationRepository locationRepo}) {
  locationRepository = locationRepo;
  runApp(const BlaBlaApp());
}

class BlaBlaApp extends StatelessWidget {
  const BlaBlaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: blaTheme,
      home: Scaffold(body: HomeScreen()),
    );
  }
}
