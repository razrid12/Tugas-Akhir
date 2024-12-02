class CurrencyService {
  Future<double> convertCurrency(double amount, String targetCurrency) async {
    // Ganti dengan logika nyata atau API konversi mata uang
    double conversionRate = 1.0;

    switch (targetCurrency) {
      case 'IDR':
        conversionRate = 15000.0; // Contoh kurs USD ke IDR
        break;
      case 'EUR':
        conversionRate = 0.92; // Contoh kurs USD ke EUR
        break;
      case 'JPY':
        conversionRate = 130.0; // Contoh kurs USD ke JPY
        break;
      default:
        conversionRate = 1.0; // Default USD
    }

    return amount * conversionRate;
  }
}
