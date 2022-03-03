part of 'shop_cubit.dart';

@immutable
abstract class ShopStates {}

class ShopInitial extends ShopStates {}

class ShopBotNavState extends ShopStates {}

class ShopBannersSuccessState extends ShopStates {}

class ShopBannersLoadingState extends ShopStates {}

class ShopProductsState extends ShopStates {}
