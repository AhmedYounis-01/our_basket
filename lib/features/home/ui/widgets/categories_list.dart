import 'package:e_commerce_supabase/core/utils/colors.dart';
import 'package:flutter/material.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.kPrimaryColor,
                  foregroundColor: AppColors.kWhiteColor,
                  child: Icon(categories[index].icon, size: 40),
                ),
                Text(categories[index].text, style: TextStyle(fontSize: 10)),
              ],
            ),
          );
        },
      ),
    );
  }
}

List<Category> categories = [
  Category(icon: Icons.sports, text: "Sports"),
  Category(icon: Icons.tv, text: "Electronics"),
  Category(icon: Icons.image, text: "Collections"),
  Category(icon: Icons.book, text: "Books"),
  Category(icon: Icons.gamepad, text: "Games"),
  Category(icon: Icons.bike_scooter, text: "Bikes"),
];

class Category {
  final IconData icon;
  final String text;

  Category({required this.icon, required this.text});
}
