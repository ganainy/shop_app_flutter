part of 'search_cubit.dart';

@immutable
abstract class SearchStates {}

class SearchInitial extends SearchStates {}

class SearchLoading extends SearchStates {}

class SearchSuccess extends SearchStates {}

class LocalChangeFavoriteState extends SearchStates {}

class SearchError extends SearchStates {
  final String errorMessage;

  SearchError(this.errorMessage);
}
