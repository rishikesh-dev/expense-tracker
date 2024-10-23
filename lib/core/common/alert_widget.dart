import 'package:expense_tracker/core/common/text_button_widget.dart';
import 'package:expense_tracker/core/common/text_field_widget.dart';
import 'package:flutter/material.dart';

class AlertWidget extends StatelessWidget {
  const AlertWidget({
    super.key,
    required this.titleController,
    required this.subTitleController,
    required this.onSave,
    required this.onCancel,
    required this.amountController,
    required this.pickedDate,
  });

  final TextEditingController titleController;
  final TextEditingController subTitleController;
  final TextEditingController amountController;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  final VoidCallback pickedDate;
  @override
  Widget build(BuildContext context) {
    // final pickeDate =
    //     '${_selectedDate?.day}/${_selectedDate!.month}/${_selectedDate!.year}';
    return AlertDialog(
      title: const Text("Create New Expense"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFieldWidget(
            controller: titleController,
            controllerName: 'Title',
            textInputType: TextInputType.text,
          ),
          TextFieldWidget(
            controller: amountController,
            controllerName: '\$ Amount',
            textInputType: TextInputType.number,
          ),
          TextButton(
            onPressed: pickedDate,
            child: const Text('Select a Date'),
          ),
        ],
      ),
      actions: [
        TextButtonWidget(
          onPressed: onCancel,
          label: 'Cancel',
        ),
        TextButtonWidget(
          onPressed: onSave,
          label: 'Save',
        ),
      ],
    );
  }
}

bool isExpense = true;
bool isIncome = false;
