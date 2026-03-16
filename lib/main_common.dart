import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/repositories/location/location_repository.dart';
import 'data/repositories/ride_preference/ride_preference_repository.dart';
import 'ui/screens/home/home_screen.dart';
import 'ui/states/ride_prefs_state.dart';
import 'ui/theme/theme.dart';

late LocationRepository locationRepository;

void mainCommon({
  required LocationRepository locationRepo,
  required RidePreferenceRepository ridePrefRepo,
}) {
  locationRepository = locationRepo;
  runApp(BlaBlaApp(ridePrefRepo: ridePrefRepo));
}

class BlaBlaApp extends StatelessWidget {
  final RidePreferenceRepository ridePrefRepo;
  const BlaBlaApp({super.key, required this.ridePrefRepo});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // Create the state and immediately call init() to load data
      create: (_) => RidePrefsState(repo: ridePrefRepo)..init(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: blaTheme,
        home: Scaffold(body: HomeScreen()),
      ),
    );
  }
}