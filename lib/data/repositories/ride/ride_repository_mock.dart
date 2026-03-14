import '../../../model/ride/ride.dart';
import '../../../model/ride_pref/ride_pref.dart';
import '../../dummy_data.dart';
import 'ride_repository.dart';

class RideRepositoryMock implements RideRepository {
  @override
  Future<List<Ride>> getRidesFor(RidePreference preferences) async {
    return fakeRides
      .where((ride) =>
        ride.departureLocation == preferences.departure &&
        ride.arrivalLocation == preferences.arrival &&
        ride.availableSeats >= preferences.requestedSeats,
      )
      .toList();
  }
}
