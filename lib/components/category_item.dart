import 'package:flutter/material.dart';
import 'package:meals/util/app_routes.dart';

import '../models/category.dart';

class CategoryItem extends StatelessWidget {
  final Category category;
 
  CategoryItem(this.category);

  void _selectedCategory(BuildContext context) {
    // muda para outra tela
    /* Navigator.of(context).push(MaterialPageRoute(
      builder: (_) {
        return CategoriesMealsScreen();
      },
    ));*/

    // Navega para um rota nomeada passando category
    Navigator.of(context).pushNamed(
      AppRoutes.CATEGORIES_MEALS,
      arguments: category,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectedCategory(context),
      // borda do inkwell precisa combinar com o container
      borderRadius: BorderRadius.circular(15),
      // cor do foco ao clicar
      splashColor: Theme.of(context).primaryColor,
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.5),
              category.color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }
}
