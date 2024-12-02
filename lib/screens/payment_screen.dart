import 'package:e_commerce/services/api_services.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  final List<Map<String, dynamic>> products;

  PaymentScreen({required this.products});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  ApiService apiService = ApiService();
  bool isLoading = false;

  double calculateTotal(List<Map<String, dynamic>> products) {
    return products.fold(
        0, (sum, item) => sum + item['item_data']['price_money']['amount']);
  }

  Future<void> makePayment() async {
    setState(() {
      isLoading = true;
    });

    Map<String, dynamic> paymentData = {
      'amount_money': {
        'amount': (calculateTotal(widget.products) * 100).toInt(),
        'currency': 'IDR',
      },
      'source_id': 'nonce_from_your_payment_method',
      'idempotency_key': DateTime.now().millisecondsSinceEpoch.toString(),
    };

    try {
      await apiService.createPayment(paymentData);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Pembayaran Berhasil!')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Pembayaran Gagal!')));
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pembayaran')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text('Total: Rp${calculateTotal(widget.products)}'),
                  ElevatedButton(
                    onPressed: makePayment,
                    child: Text('Lakukan Pembayaran'),
                  ),
                ],
              ),
            ),
    );
  }
}
