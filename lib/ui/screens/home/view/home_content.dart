import 'package:flutter/material.dart';
import 'package:week8_promise/model/ride_pref/ride_pref.dart';
import 'package:week8_promise/ui/screens/home/viewmodel/home_view_model.dart';
import 'package:week8_promise/ui/screens/home/widgets/home_history_tile.dart';
import 'package:week8_promise/ui/screens/rides_selection/rides_selection_screen.dart';
import 'package:week8_promise/ui/theme/theme.dart';
import 'package:week8_promise/ui/widgets/pickers/bla_ride_preference_picker.dart';
import 'package:week8_promise/utils/animations_util.dart';

const String blablaHomeImagePath = 'assets/images/blabla_home.png';

class HomeContent extends StatefulWidget {
  final HomeViewModel viewModel; // ← ViewModel passed via constructor

  const HomeContent({super.key, required this.viewModel});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  // Convenience getter so we don't write widget.viewModel everywhere
  HomeViewModel get viewModel => widget.viewModel;

  void onRidePrefSelected(RidePreference selectedPreference) async {
    // 1 - Tell the ViewModel to update the preference
    await viewModel.selectPreference(selectedPreference);

    // 2 - Navigate to rides screen
    await Navigator.of(context).push(
      AnimationUtils.createBottomToTopRoute(RidesSelectionScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [_buildBackground(), _buildForeground()]);
  }

  Widget _buildForeground() {
    // ListenableBuilder rebuilds this widget whenever viewModel.notifyListeners() is called
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        return Column(
          children: [
            // 1 - HEADER
            const SizedBox(height: 16),
            Align(
              alignment: AlignmentGeometry.center,
              child: Text(
                "Your pick of rides at low price",
                style: BlaTextStyles.heading.copyWith(color: Colors.white),
              ),
            ),
            const SizedBox(height: 100),

            // 2 - FORM + HISTORY CARD
            Container(
              margin: EdgeInsets.symmetric(horizontal: BlaSpacings.xxl),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BlaRidePreferencePicker(
                    initRidePreference: viewModel.currentPref,
                    onRidePreferenceSelected: onRidePrefSelected,
                  ),
                  SizedBox(height: BlaSpacings.m),
                  _buildHistory(),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildHistory() {
    List<RidePreference> history =
        viewModel.preferenceHistory.reversed.toList();
    return SizedBox(
      height: 200,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
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
      child: Image.asset(blablaHomeImagePath, fit: BoxFit.cover),
    );
  }
}