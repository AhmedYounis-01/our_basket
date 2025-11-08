import 'package:e_commerce_supabase/features/favorite/ui/favorite_screen.dart';
import 'package:e_commerce_supabase/features/home/ui/home_screen.dart';
import 'package:e_commerce_supabase/features/profile/ui/profile_screen.dart';
import 'package:e_commerce_supabase/features/store/ui/store_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'nav_bar_state.dart';

class NavBarCubit extends Cubit<NavBarState> {
  NavBarCubit() : super(const NavBarState());

  void changeTab(int index) {
    emit(state.copyWith(currentIndex: index));
  }

  List<Widget> get pages => [
    const HomeScreen(),
    const StoreScreen(),
    const FavoriteScreen(),
    const ProfileScreen(),
  ];
}
