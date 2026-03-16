import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week8_promise/ui/states/ride_prefs_state.dart';
import '../../../model/ride/ride.dart';
import '../../../model/ride_pref/ride_pref.dart';
import '../../../services/rides_service.dart';
import '../../../utils/animations_util.dart' show AnimationUtils;
import '../../theme/theme.dart';
import 'widgets/ride_preference_modal.dart';
import 'widgets/rides_selection_header.dart';
import 'widgets/rides_selection_tile.dart';

///
///  The Ride Selection screen allows user to select a ride, once ride preferences have been defined.
///  The screen also allow user to:
///   -  re-define the ride preferences
///   -  activate some filters.
///
class RidesSelectionScreen extends StatefulWidget {
  const RidesSelectionScreen({super.key});

  @override
  State<RidesSelectionScreen> createState() => _RidesSelectionScreenState();
}

class _RidesSelectionScreenState extends State<RidesSelectionScreen> {
  void onBackTap() {
    Navigator.pop(context);
  }

  void onFilterPressed() {
    // TODO
  }

  void onRideSelected(Ride ride) {
    // Later
  }

  RidePreference get selectedRidePreference =>
    context.read<RidePrefsState>().currentPref!;

  List<Ride> get matchingRides =>
      RidesService.getRidesFor(selectedRidePreference);

  void onPreferencePressed() async {
    // 1 - Navigate to the rides preference picker
    RidePreference? newPreference = await Navigator.of(context)
        .push<RidePreference>(
          AnimationUtils.createRightToLeftRoute(
            RidePreferenceModal(initialPreference: selectedRidePreference),
          ),
        );

    if (newPreference != null) {
       // 2 - Update global state via provider (no setState needed!)
      await context.read<RidePrefsState>().setPreference(newPreference);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<RidePrefsState>();
    final currentPref = state.currentPref!;
    final rides = RidesService.getRidesFor(currentPref);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: BlaSpacings.m, right: BlaSpacings.m, top: BlaSpacings.s),
        child: Column(
          children: [
            RideSelectionHeader(
              ridePreference: selectedRidePreference,
              onBackPressed: onBackTap,
              onFilterPressed: onFilterPressed,
              onPreferencePressed: onPreferencePressed,
            ),
        
            SizedBox(height: 100),
        
            Expanded(
              child: ListView.builder(
                itemCount: rides.length,
                itemBuilder: (ctx, index) => RideSelectionTile(
                  ride: rides[index],
                  onPressed: () => onRideSelected(rides[index]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
