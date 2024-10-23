import 'package:expense_tracker/model/expense_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DataService {
  final Box<ExpenseModel>
      box; // Make sure to specify the type for better type safety
  List<ExpenseModel> expenses = [];
  DataService()
      : box = Hive.box<ExpenseModel>(
            'expenses'); // Ensure the box is initialized with the correct type

  // Create expense
  void createExpense(ExpenseModel expense) {
    box.add(expense); // Add the expense to the box
    expenses.add(expense); // Keep the local list updated
  }

  // Fetch all expenses
  void fetchExpenses() {
    expenses = box.values.toList(); // Get all expenses from the box
  }

  // Delete Expense
  void deleteExpense(int index) {
    box.deleteAt(index); // Delete the expense at the specified index
    expenses.removeAt(index); // Also remove it from the local list
  }
  
}
