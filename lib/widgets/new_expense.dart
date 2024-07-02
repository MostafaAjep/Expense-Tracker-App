import 'dart:io';

import 'package:expenses_app/models/expense_model.dart';
import 'package:expenses_app/widgets/amount_field.dart';
import 'package:expenses_app/widgets/buttons_row.dart';
import 'package:expenses_app/widgets/date_picker.dart';
import 'package:expenses_app/widgets/title_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dropdown.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final Function(ExpenseModel expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;
  final formater = DateFormat.yMd();

  void _presentDatePicker() async {
    final DateTime now = DateTime.now();
    final DateTime firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void showDialogue() {
    if (Platform.isIOS) {
      showCupertinoDialog(
          context: context,
          builder: (ctx) => CupertinoAlertDialog(
                title: const Text('Invalid input'),
                content: const Text(
                    'Please, provide a valid title, amount and date'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('OK'))
                ],
              ));
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text('Please, provide a valid title, amount and date'),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(ctx), child: const Text('OK'))
          ],
        ),
      );
    }
  }

  void submitExpenseData() {
    final double? enteredAmount = double.tryParse(amountController.text);
    final bool amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialogue();
      return;
    }
    widget.onAddExpense(
      ExpenseModel(
        title: titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(
      builder: (ctx, constraints) {
        final width = constraints.maxWidth;
        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
              child: Column(
                children: [
                  if (width >= 600)
                    Row(
                      children: [
                        Expanded(
                          child: TitleTextField(controller: titleController),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: AmountTextField(controller: amountController),
                        ),
                      ],
                    )
                  else
                    TitleTextField(controller: titleController),
                  if (width >= 600)
                    Row(
                      children: [
                        CategoryDropdown(
                          selectedCategory: _selectedCategory,
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _selectedCategory = value;
                            });
                          },
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: DatePickerRow(
                            selectedDate: _selectedDate,
                            onDatePickerPressed: _presentDatePicker,
                            formater: formater,
                          ),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        Expanded(
                          child: AmountTextField(controller: amountController),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: DatePickerRow(
                            selectedDate: _selectedDate,
                            onDatePickerPressed: _presentDatePicker,
                            formater: formater,
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 16),
                  if (width >= 600)
                    ButtonsRow(
                      onCancelPressed: () {
                        Navigator.pop(context);
                      },
                      onSavePressed: submitExpenseData,
                    )
                  else
                    Row(
                      children: [
                        CategoryDropdown(
                          selectedCategory: _selectedCategory,
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _selectedCategory = value;
                            });
                          },
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: submitExpenseData,
                          child: const Text('Save expense'),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
