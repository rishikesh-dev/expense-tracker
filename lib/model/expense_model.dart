import 'package:hive/hive.dart';
part 'expense_model.g.dart';

enum ExpenseOrIncome { expense, income }

@HiveType(typeId: 0) // Give it a unique type ID
class ExpenseModel {
  @HiveField(0)
  final double amount;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String subTitle;

  @HiveField(3)
  final DateTime dateTime;

  ExpenseModel({
    required this.amount,
    required this.title,
    required this.subTitle,
    required this.dateTime,
  });
}
