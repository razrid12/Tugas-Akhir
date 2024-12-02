import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String apiUrlCatalog = 'https://connect.squareup.com/v2/catalog/object';
  final String apiUrlPayment = 'https://connect.squareup.com/v2/payments';
  final String accessToken =
      'EAAAl6mLWGjIg1AisioP5QMq_ohtwglRXaam8Vd11nnuPn_YVzyZuJS5nzNfO4X0';

  // Mengambil produk dari katalog
  Future<List<Map<String, dynamic>>> getCatalog() async {
    try {
      final response = await http.get(
        Uri.parse(apiUrlCatalog),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        List<Map<String, dynamic>> products =
            List<Map<String, dynamic>>.from(data['objects']);
        return products;
      } else {
        print('Failed to load catalog');
        return [];
      }
    } catch (e) {
      print('Error occurred while fetching catalog: $e');
      return [];
    }
  }

  // Membuat pembayaran
  Future<void> createPayment(Map<String, dynamic> paymentData) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrlPayment),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: json.encode(paymentData),
      );

      if (response.statusCode == 200) {
        print('Payment Successful');
        var responseData = json.decode(response.body);
        print(responseData);
      } else {
        print('Payment Failed');
        var errorResponse = json.decode(response.body);
        print('Error: ${errorResponse['errors']}');
      }
    } catch (e) {
      print('An error occurred while processing the payment: $e');
    }
  }
}
