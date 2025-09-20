class Expense {
final String id;
final String title;
final double amount;
final DateTime date;
final String currency; // ISO code like "USD", "CAD"...


Expense({
required this.id,
required this.title,
required this.amount,
required this.date,
this.currency = 'CAD',
});
}