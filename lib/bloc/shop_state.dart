part of 'shop_cubit.dart';

@immutable
abstract class ShopStates {}

class ShopInitial extends ShopStates {}

class ShopBotNavState extends ShopStates {}

class ShopBannersSuccessState extends ShopStates {}

class ShopCategoriesSuccessState extends ShopStates {}

class ShopCategoryProductsSuccessState extends ShopStates {}

class ShopFavoritesSuccessState extends ShopStates {}

class LocalChangeFavoriteState extends ShopStates {}

class ShopFavoritesLoadingState extends ShopStates {}

class UpdateFavoritesSuccessState extends ShopStates {}

class ShopBannersLoadingState extends ShopStates {}

class ShopProductsState extends ShopStates {}

class ProfileGetSuccess extends ShopStates {}

class ProfileGetLoading extends ShopStates {}

class ProfileGetError extends ShopStates {}

class ProfileUpdateSuccess extends ShopStates {}

class ProfileUpdateLoading extends ShopStates {}

class ProfileUpdateError extends ShopStates {}
