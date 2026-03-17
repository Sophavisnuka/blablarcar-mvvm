import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week8_promise/ui/screens/home/view/home_content.dart';
import 'package:week8_promise/ui/screens/home/viewmodel/home_view_model.dart';
import 'package:week8_promise/ui/states/ride_prefs_state.dart';

class HomeScreen extends StatefulWidget {         // ← change to StatefulWidget
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    // Create the ViewModel once, grab RidePrefsState from the tree
    _viewModel = HomeViewModel(context.read<RidePrefsState>());
  }

  @override
  void dispose() {
    _viewModel.dispose(); // cleans up the addListener
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HomeContent(viewModel: _viewModel);
  }
}