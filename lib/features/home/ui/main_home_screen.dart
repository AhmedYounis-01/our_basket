import 'package:flutter/material.dart';
import 'package:e_commerce_supabase/features/home/logic/cubit/home_cubit.dart';
import 'package:e_commerce_supabase/features/home/logic/cubit/home_state.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainHomeScreen extends StatelessWidget {
  const MainHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          HomeCubit cubit = context.read<HomeCubit>();
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: cubit.pages[state.currentIndex],
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
