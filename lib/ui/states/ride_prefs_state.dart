import 'package:flutter/material.dart';
import 'package:week8_promise/data/repositories/ride_preference/ride_preference_repository.dart';
import 'package:week8_promise/model/ride_pref/ride_pref.dart';

class RidePrefsState extends ChangeNotifier {

  final RidePreferenceRepository repo;
  RidePreference? currentPref;
  List<RidePreference> preferenceHistory = [];

  RidePrefsState({
    required this.repo
  });

  Future<void> init() async {
    currentPref = await repo.getSelectedPreference();
    preferenceHistory = await repo.getPreferenceHistory();
    notifyListeners();
  }

  Future<void> setPreference(RidePreference preference) async {
    await repo.setSelectedPreference(preference);
    currentPref = preference;
    preferenceHistory = await repo.getPreferenceHistory();
    notifyListeners();
  }
}