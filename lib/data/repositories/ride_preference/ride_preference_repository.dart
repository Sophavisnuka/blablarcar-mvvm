import '../../../model/ride_pref/ride_pref.dart';

abstract class RidePreferenceRepository {
  int get maxAllowedSeats;

  Future<RidePreference?> getSelectedPreference();

  Future<List<RidePreference>> getPreferenceHistory();

  Future<void> setSelectedPreference(RidePreference preference);
}
