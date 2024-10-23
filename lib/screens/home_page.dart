import 'package:expense_tracker/core/common/alert_widget.dart';
import 'package:expense_tracker/core/common/expense_tile.dart';
import 'package:expense_tracker/model/expense_model.dart';
import 'package:expense_tracker/services/data_service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

TextEditingController _title = TextEditingController();
TextEditingController _subTitle = TextEditingController();
TextEditingController _amount = TextEditingController();
final DataService dataService = DataService();
DateTime _selectedDate = DateTime.now();

class _HomePageState extends State<HomePage> {
  List<ExpenseModel> expenses = [];
  @override
  void initState() {
    super.initState();
    fetchExpenses();
  }

  void fetchExpenses() {
    dataService.fetchExpenses();
    setState(() {}); // Update the UI after fetching expenses
  }

  void _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void createExpense() {
    final double amount =
        double.tryParse(_amount.text) ?? 0.0; // Parse the amount
    if (_title.text.isNotEmpty && amount.toString().isNotEmpty) {
      // Check if fields are not empty
      ExpenseModel expense = ExpenseModel(
        amount: amount,
        title: _title.text,
        subTitle: _subTitle.text,
        dateTime: _selectedDate,
      );

      setState(() {
        dataService
            .createExpense(expense); // Create the expense and update state
      });
      _title.clear();
      _subTitle.clear();
      _amount.clear();
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill the form'),
        ),
      );
    }
  }

  void onDelete(ExpenseModel expense, int index) {
    setState(() {
      dataService.box.deleteAt(index);
      fetchExpenses(); // Refresh the list of expenses after deletion
    });
  }

  double calculateTotalForDay(DateTime selectedDate) {
    return dataService.expenses
        .where((expense) => isSameDay(expense.dateTime, selectedDate))
        .fold(0, (sum, expense) => sum + expense.amount);
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  Map<String, double> groupExpensesByCategory() {
    Map<String, double> groupedExpenses = {};

    for (var expense in dataService.expenses) {
      String day =
          "${expense.dateTime.year}-${expense.dateTime.month}-${expense.dateTime.day}"; // Group by day
      if (groupedExpenses.containsKey(day)) {
        groupedExpenses[day] = groupedExpenses[day]! + expense.amount;
      } else {
        groupedExpenses[day] = expense.amount;
      }
    }

    return groupedExpenses;
  }

  List<PieChartSectionData> createChartSections() {
    Map<String, double> groupedExpenses = groupExpensesByCategory();

    return groupedExpenses.entries.map((entry) {
      return PieChartSectionData(
        titleStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        gradient: LinearGradient(
          colors: gradientColors,
        ),
        value: entry.value,
        title: '₹ ${entry.value.toStringAsFixed(0)}',
        radius: 50,
      );
    }).toList();
  }

  List<Color> gradientColors = [
    Colors.green.shade900,
    Colors.green.shade600,
    Colors.green.shade300,
  ];

  @override
  Widget build(BuildContext context) {
    final expenses = dataService.expenses;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              child: PieChart(
                PieChartData(
                  sections:
                      createChartSections(), // Generate pie chart sections
                  sectionsSpace: 4,
                  centerSpaceRadius: 40,
                  borderData: FlBorderData(show: false),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              reverse: true,
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                final expense = expenses[index];
                return ExpenseTile(
                  title: expense.title,
                  subTitle: expense.subTitle,
                  amount: expense.amount,
                  dateTime: expense.dateTime,
                  onDismissed: () => onDelete(
                      expense, index), // Call onDelete with the expense
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertWidget(
              titleController: _title,
              subTitleController: _subTitle,
              amountController: _amount,
              onSave: createExpense,
              onCancel: () {
                Navigator.of(context).pop();
              },
              pickedDate: _pickDate,
            ),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
