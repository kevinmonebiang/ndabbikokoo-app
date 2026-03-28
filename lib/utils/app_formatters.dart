String formatCurrency(double amount) {
  final fixed = amount.toStringAsFixed(0);
  final reversed = fixed.split('').reversed.join();
  final grouped = reversed.replaceAllMapped(
    RegExp(r'.{1,3}'),
    (match) => '${match.group(0)} ',
  );

  return '${grouped.trim().split('').reversed.join()} EUR';
}

String formatShortDate(DateTime date) {
  const months = <int, String>{
    1: 'janv.',
    2: 'fevr.',
    3: 'mars',
    4: 'avr.',
    5: 'mai',
    6: 'juin',
    7: 'juil.',
    8: 'aout',
    9: 'sept.',
    10: 'oct.',
    11: 'nov.',
    12: 'dec.',
  };

  return '${date.day} ${months[date.month]} ${date.year}';
}

