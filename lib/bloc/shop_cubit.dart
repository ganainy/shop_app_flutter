import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app_flutter/network/cache_helper.dart';
import 'package:shop_app_flutter/screens/login.dart';
import 'package:shop_app_flutter/shared/components.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitial());

  static ShopCubit get(context) => BlocProvider.of(context);

  void logOut(BuildContext context) {
    CacheHelper.removeData(key: 'token').then((value) {
      navigateToAndFinish(context: context, screen: LoginScreen());
    });
  }
}
