part of 'favorties_bloc.dart';

@immutable
sealed class FavortiesEvent {}

final class FavortiesFetchEvent extends FavortiesEvent {}
