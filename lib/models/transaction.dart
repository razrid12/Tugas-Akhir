class Transaction {
  final String id;
  final String productId;
  final double amount;
  final DateTime date;
  final String status;

  Transaction({
    required this.id,
    required this.productId,
    required this.amount,
    required this.date,
    required this.status,
  });

  // Method untuk konversi transaksi ke Map untuk penyimpanan lokal
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'amount': amount,
      'date': date.toIso8601String(),
      'status': status,
    };
  }
}
