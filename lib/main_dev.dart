import 'package:week8_promise/data/repositories/ride_preference/ride_preference_repository_mock.dart';

import 'data/repositories/location/location_repository_mock.dart';
import 'main_common.dart';

void main() => mainCommon(
  locationRepo: LocationRepositoryMock(),
  ridePrefRepo: RidePreferenceRepositoryMock()
);
