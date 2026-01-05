String getCurrencyPrefix(String currency) {
  switch (currency) {
    case 'USD':
      return '\$';
    case 'EUR':
      return '€';
    case 'GBP':
      return '£';
    case 'INR':
      return '₹';
    default:
      return '\$';
  }
}
