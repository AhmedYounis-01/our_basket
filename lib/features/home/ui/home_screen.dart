import 'package:e_commerce_supabase/features/home/logic/cubit/home_cubit.dart';
import 'package:e_commerce_supabase/features/home/logic/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // List of pages to display
  static final List<Widget> _pages = [
    const Center(child: Text('Home Page', style: TextStyle(fontSize: 24))),
    const Center(child: Text('Store Page', style: TextStyle(fontSize: 24))),
    const Center(child: Text('Favorites Page', style: TextStyle(fontSize: 24))),
    const Center(child: Text('Profile Page', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: _pages[state.currentIndex],
              ),
            ),
            bottomNavigationBar: CurvedNavigationBar(
              index: state.currentIndex,
              height: 60,
              backgroundColor: Colors.transparent,
              color: Colors.blue,
              buttonBackgroundColor: Colors.blue,
              animationDuration: const Duration(milliseconds: 300),
              items: const [
                Icon(Icons.home, size: 30, color: Colors.white),
                Icon(Icons.store, size: 30, color: Colors.white),
                Icon(Icons.favorite, size: 30, color: Colors.white),
                Icon(Icons.person, size: 30, color: Colors.white),
              ],
              onTap: (index) {
                context.read<HomeCubit>().changeTab(index);
              },
            ),
          );
        },
      ),
    );
  }
}
