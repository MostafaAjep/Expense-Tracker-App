import 'package:flutter/material.dart';
import 'package:expenses_app/models/expense_model.dart';

class CategoryDropdown extends StatelessWidget {
  final Category selectedCategory;
  final ValueChanged<Category?> onChanged;

  const CategoryDropdown({
    super.key,
    required this.selectedCategory,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Category>(
      value: selectedCategory,
      items: Category.values
          .map(
            (category) => DropdownMenuItem<Category>(
              value: category,
              child: Text(category.name.toUpperCase()),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}
