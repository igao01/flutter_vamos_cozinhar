import 'package:flutter/material.dart';
import 'package:meals/components/tag_button.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/util/app_routes.dart';
import 'categories_meals_screen.dart';

class MealDetailScreen extends StatelessWidget {
  final Function(Meal) onToggleFavorite;
  final bool Function(Meal) isFavorite;

  MealDetailScreen(this.onToggleFavorite, this.isFavorite, {Key? key}) : super(key: key);

  Widget _createSectionTitle(BuildContext context, String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget _createSectionContainer(Widget child) {
    return Container(
      width: 330,
      height: 200,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      child: child,
    );
  }

  List<Widget> _createTags(Meal meal, BuildContext context) {
    List<TagButton> tagButtons = [];

    if (meal.isGlutenFree) {
      tagButtons.add(
        TagButton(
          label: 'Sem Gluten',
          context: context,
        ),
      );
    }
    if (meal.isLactoseFree) {
      tagButtons.add(
        TagButton(
          label: 'Sem Lactose',
          context: context,
        ),
      );
    }
    if (meal.isVegan) {
      tagButtons.add(
        TagButton(
          label: 'Vegana',
          context: context,
        ),
      );
    }
    if (meal.isVegetarian) {
      tagButtons.add(
        TagButton(
          label: 'Vegetariana',
          context: context,
        ),
      );
    }

    return tagButtons;
  }

  @override
  Widget build(BuildContext context) {
    // Pega o a refeição passa como argumento no settings
    final meal = ModalRoute.of(context)!.settings.arguments as Meal;

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushReplacementNamed(AppRoutes.HOME),
            icon: Icon(Icons.home),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                meal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: _createTags(meal, context),
            ),
            _createSectionTitle(context, 'Ingredientes'),
            _createSectionContainer(
              ListView.builder(
                itemCount: meal.ingredients.length,
                itemBuilder: (ctx, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      child: Text(
                        '${meal.ingredients[index]}',
                      ),
                    ),
                    color: Theme.of(context).accentColor,
                  );
                },
              ),
            ),
            _createSectionTitle(context, 'Modo de Preparo'),
            _createSectionContainer(
              ListView.builder(
                itemCount: meal.steps.length,
                itemBuilder: (ctx, index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          radius: 18,
                          child: Text('${index + 1}'),
                        ),
                        title: Text(meal.steps[index]),
                      ),
                      Divider(),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(isFavorite(meal) ? Icons.star : Icons.star_border),
        // pop() pode receber um valor que é retornado
        // para tela anterior
        onPressed: () => onToggleFavorite(meal),
      ),
    );
  }
}
