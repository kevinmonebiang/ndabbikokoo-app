class Payment {
  const Payment({
    required this.label,
    required this.reference,
    required this.method,
    required this.amount,
    required this.paidOn,
    required this.statusLabel,
  });

  final String label;
  final String reference;
  final String method;
  final double amount;
  final DateTime paidOn;
  final String statusLabel;
}

