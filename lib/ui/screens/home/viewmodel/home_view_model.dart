import 'package:flutter/material.dart';
import 'package:week8_promise/model/ride_pref/ride_pref.dart';
import 'package:week8_promise/ui/states/ride_prefs_state.dart';

class HomeViewModel extends ChangeNotifier{
  final RidePrefsState ridePrefsState;

  HomeViewModel(this.ridePrefsState) {
    ridePrefsState.addListener(_onStateChanged);
  }

  void _onStateChanged() {
    notifyListeners();
  }
  
  RidePreference? get currentPref => ridePrefsState.currentPref;
  List<RidePreference> get preferenceHistory => ridePrefsState.preferenceHistory;

  Future<void> selectPreference(RidePreference preference) async {
    await ridePrefsState.setPreference(preference);
  }

  @override
  void dispose() {
    ridePrefsState.removeListener(_onStateChanged); // always clean up!
    super.dispose();
  }

}