part of 'product_cubit.dart';

@immutable
abstract class ProductStates {}

class ProductInitial extends ProductStates {}

class FavoriteUpdateState extends ProductStates {}

class ExpandShrinkDescriptionState extends ProductStates {}
