enum RegionRadiusEnum { city, state, region }

String regionRadiusEnumToString(RegionRadiusEnum regionRadius) {
  return regionRadius.toString().split('.').last;
}

RegionRadiusEnum regionRadiusEnumFromString(String regionRadius) {
  switch (regionRadius) {
    case 'city':
      return RegionRadiusEnum.city;
    case 'state':
      return RegionRadiusEnum.state;
    default:
      return RegionRadiusEnum.region;
  }
}
