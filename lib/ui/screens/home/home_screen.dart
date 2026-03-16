import 'package:provider/provider.dart';
import 'package:week8_promise/model/ride_pref/ride_pref.dart';
import 'package:flutter/material.dart';
import 'package:week8_promise/ui/states/ride_prefs_state.dart';
import '../../../utils/animations_util.dart';
import '../../theme/theme.dart';
import '../../widgets/pickers/bla_ride_preference_picker.dart';
import '../rides_selection/rides_selection_screen.dart';
import 'widgets/home_history_tile.dart';

const String blablaHomeImagePath = 'assets/images/blabla_home.png';

///
/// This screen allows user to:
/// - Enter his/her ride preference and launch a search on it
/// - Or select a last entered ride preferences and launch a search on it
///
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void onRidePrefSelected(RidePreference selectedPreference) async {
    // 1- Ask the service to update the current preference
    await context.read<RidePrefsState>().setPreference(selectedPreference);

    // 2 - Navigate to the rides screen
    await Navigator.of(context).push(
      AnimationUtils.createBottomToTopRoute(RidesSelectionScreen())
    );
  }

  @override
  Widget build(context) {
    return Stack(children: [_buildBackground(), _buildForeground()]);
  }

  Widget _buildForeground() {
    final state = context.watch<RidePrefsState>();
    return Column(
      children: [
        // 1 - THE HEADER
        SizedBox(height: 16),
        Align(
          alignment: AlignmentGeometry.center,
          child: Text(
            "Your pick of rides at low price",
            style: BlaTextStyles.heading.copyWith(color: Colors.white),
          ),
        ),
        SizedBox(height: 100),

        Container(
          margin: EdgeInsets.symmetric(horizontal: BlaSpacings.xxl),
          decoration: BoxDecoration(
            color: Colors.white, // White background
            borderRadius: BorderRadius.circular(16), // Rounded corners
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 2 - THE FORM
              BlaRidePreferencePicker(
                initRidePreference: state.currentPref,
                onRidePreferenceSelected: onRidePrefSelected,
              ),
              SizedBox(height: BlaSpacings.m),

              // 3 - THE HISTORY
              _buildHistory(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHistory() {
    final state = context.watch<RidePrefsState>();
    // Reverse the history of preferences
    List<RidePreference> history = state.preferenceHistory.reversed
        .toList();
    return SizedBox(
      height: 200, // Set a fixed height
      child: ListView.builder(
        shrinkWrap: true, // Fix ListView height issue
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: history.length,
        itemBuilder: (ctx, index) => HomeHistoryTile(
          ridePref: history[index],
          onPressed: () => onRidePrefSelected(history[index]),
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return SizedBox(
      width: double.infinity,
      height: 340,
      child: Image.asset(
        blablaHomeImagePath,
        fit: BoxFit.cover, // Adjust image fit to cover the container
      ),
    );
  }
}
