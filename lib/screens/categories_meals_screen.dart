import 'package:flutter/material.dart';
import 'package:meals/components/meal_item.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/util/app_routes.dart';

class CategoriesMealsScreen extends StatefulWidget {
  final List<Meal>? meals;
  final String? tag;

  CategoriesMealsScreen({this.meals, this.tag});

  @override
  _CategoriesMealsScreenState createState() => _CategoriesMealsScreenState();
}

class _CategoriesMealsScreenState extends State<CategoriesMealsScreen> {
  String titleAppBar = 'Refeições';

  void _mealsByTag() {
    setState(() {
      var meals = DUMMY_MEALS.where((meal) {
        if (widget.tag == 'Sem Gluten') {
          return meal.isGlutenFree == true;
        } else if (widget.tag == 'Sem Lactose') {
          return meal.isLactoseFree == true;
        } else if (widget.tag == 'Vegana') {
          return meal.isVegan == true;
        } else {
          return meal.isVegetarian == true;
        }
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final categoryMeal;
    final Category category;

    if (widget.tag != null) {
      setState(() {
        titleAppBar = widget.tag!;
      });
      categoryMeal = DUMMY_MEALS.where((meal) {
        // verifica se a refeicao "meal" possui o id da categoria "category"
        switch (widget.tag) {
          case 'Sem Gluten':
            return meal.isGlutenFree == true;
          case 'Sem Lactose':
            return meal.isLactoseFree == true;
          case 'Vegana':
            return meal.isVegan == true;
          case 'Vegetariana':
            return meal.isVegetarian == true;
          default:
            return false;
        }
      }).toList();
    } else {
      // pega a categoria atraves da navegacao
      category = ModalRoute.of(context)!.settings.arguments as Category;

      setState(() {
        titleAppBar = category.title;
      });

      categoryMeal = widget.meals!.where((meal) {
        // verifica se a refeicao "meal" possui o id da categoria "category"
        return meal.categories.contains(category.id);
      }).toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(titleAppBar),
        actions: [
          IconButton(
              onPressed: () =>
                  Navigator.of(context).pushReplacementNamed(AppRoutes.HOME),
              icon: Icon(Icons.home)),
        ],
      ),
      body: categoryMeal.isEmpty
          ? Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Não há receitas',
                    style: TextStyle(
                      fontSize: 36,
                      color: Colors.grey[700],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Busque em outra categoria',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.sentiment_satisfied_alt,
                        color: Colors.grey[700],
                        size: 48,
                      ),
                    ],
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: categoryMeal.length,
              itemBuilder: (ctx, index) {
                return MealItem(categoryMeal[index]);
              },
            ),
    );
  }
}
