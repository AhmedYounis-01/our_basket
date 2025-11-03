part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {}

final class HomeError extends HomeState {}

final class AddToFavoriteLoading extends HomeState {}

final class AddToFavoriteSuccess extends HomeState {}

final class AddToFavoriteError extends HomeState {}
