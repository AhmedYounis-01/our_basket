import 'package:e_commerce_supabase/core/components/custom_search_filed.dart';
import 'package:e_commerce_supabase/core/components/product_list.dart';
import 'package:flutter/material.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: const [
          Center(
            child: Text(
              "Welcome To Our Market",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 20),
          CustomSearchField(),
          SizedBox(height: 15),
          ProductsList(),
        ],
      ),
    );
  }
}
