import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseTile extends StatelessWidget {
  const ExpenseTile({
    super.key,
    required this.title,
    required this.subTitle,
    required this.amount,
    required this.dateTime,
    required this.onDismissed,
  });
  final String title;
  final String subTitle;
  final double amount;
  final DateTime dateTime;
  final VoidCallback onDismissed;
  @override
  Widget build(BuildContext context) {
    // Format the DateTime when displaying it
    String formattedDate =
        DateFormat(DateFormat.ABBR_MONTH_WEEKDAY_DAY).format(dateTime);
    return Dismissible(
      onDismissed: (direction) => onDismissed,
      key: UniqueKey(),
      background: const ColoredBox(
        color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(Icons.delete),
            SizedBox(
              width: 18,
            ),
          ],
        ),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFbcf0b4),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            DateTime.now().day.toString(),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        title: Text(title),
        subtitle: Text(formattedDate),
        trailing: Text(
          "₹${amount.toString()}",
          style: TextStyle(
            fontSize: 15,
            color: amount < 1 ? Colors.red : Colors.green,
          ),
        ),
      ),
    );
  }
}
