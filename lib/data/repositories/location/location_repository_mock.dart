import '../../../model/ride/locations.dart';
import '../../dummy_data.dart';
import 'location_repository.dart';

class LocationRepositoryMock implements LocationRepository {
  @override
  Future<List<Location>> getLocations() async {
    return fakeLocations;
  }
}
