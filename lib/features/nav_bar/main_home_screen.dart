import 'package:flutter/material.dart';
import 'package:e_commerce_supabase/features/nav_bar/cubit/nav_bar_cubit.dart';
import 'package:e_commerce_supabase/features/nav_bar/cubit/nav_bar_state.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainHomeScreen extends StatelessWidget {
  const MainHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavBarCubit(),
      child: BlocBuilder<NavBarCubit, NavBarState>(
        builder: (context, state) {
          NavBarCubit cubit = context.read<NavBarCubit>();
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: cubit.pages[0],
              ),
            ),
            bottomNavigationBar: CurvedNavigationBar(
              index: state.currentIndex,
              height: 60,
              backgroundColor: Colors.red,
              color: Colors.red,
              buttonBackgroundColor: Colors.red,
              animationDuration: const Duration(milliseconds: 300),
              items: const [
                Icon(Icons.home, size: 30, color: Colors.white),
                Icon(Icons.store, size: 30, color: Colors.white),
                Icon(Icons.favorite, size: 30, color: Colors.white),
                Icon(Icons.person, size: 30, color: Colors.white),
              ],
              onTap: (index) {
                cubit.changeTab(index);
              },
            ),
          );
        },
      ),
    );
  }
}
