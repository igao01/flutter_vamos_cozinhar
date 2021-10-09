import 'package:flutter/material.dart';
import 'package:meals/screens/categories_meals_screen.dart';

class TagButton extends StatelessWidget {
  String label;
  BuildContext context;

  TagButton({
    required this.label,
    required this.context,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    _tagOnTap(String tag, BuildContext context) {
      Navigator.push<void>(
            context,
            MaterialPageRoute<void>(
              builder: (_) => CategoriesMealsScreen(
                tag: tag,
              ),
            ),
          );
    }

    return InkWell(
      onTap: () => _tagOnTap(label, context),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 3,
          horizontal: 8,
        ),
        margin: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).primaryColor,
        ),
        child: Text(
          label,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
