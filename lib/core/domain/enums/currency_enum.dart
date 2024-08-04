enum CurrencyEnum {
  brl,
  usd,
}

String currencyEnumToString(CurrencyEnum currency) {
  return currency.toString().split('.').last.toUpperCase();
}

CurrencyEnum currencyEnumFromString(String currencyName) {
  switch (currencyName) {
    case 'BRL':
      return CurrencyEnum.brl;
    case 'USD':
      return CurrencyEnum.usd;
    default:
      return CurrencyEnum.brl;
  }
}
