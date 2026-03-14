import '../../../model/ride_pref/ride_pref.dart';
import 'ride_preference_repository.dart';

class RidePreferenceRepositoryMock implements RidePreferenceRepository {
  RidePreference? _selectedPreference;
  final List<RidePreference> _preferenceHistory = [];

  @override
  final int maxAllowedSeats = 8;

  @override
  Future<RidePreference?> getSelectedPreference() async {
    return _selectedPreference;
  }

  @override
  Future<List<RidePreference>> getPreferenceHistory() async {
    return List.unmodifiable(_preferenceHistory);
  }

  @override
  Future<void> setSelectedPreference(RidePreference preference) async {
    if (preference != _selectedPreference) {
      _selectedPreference = preference;
      _preferenceHistory.add(preference);
    }
  }
}
