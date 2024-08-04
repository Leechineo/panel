enum CountryEnum { br, cn }

String countryEnumToString(CountryEnum country) {
  return country.toString().split('.').last;
}

CountryEnum countryEnumFromString(String countryName) {
  switch (countryName) {
    case 'br':
      return CountryEnum.br;
    case 'cn':
      return CountryEnum.cn;
    default:
      return CountryEnum.br;
  }
}
