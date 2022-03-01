import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app_flutter/layouts/shop_layout.dart';
import 'package:shop_app_flutter/network/cache_helper.dart';
import 'package:shop_app_flutter/screens/login.dart';
import 'package:shop_app_flutter/shared/components.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainStates> {
  MainCubit() : super(MainInitial());

  static MainCubit get(context) => BlocProvider.of(context);

  void getStartScreen(BuildContext context) {
// navigate to shop, login or stay at on boarding screen
    CacheHelper.getData(key: 'showOnBoarding').then((showOnBoarding) {
      CacheHelper.getData(key: 'token').then((token) {
        if (showOnBoarding != null && !(showOnBoarding as bool)) {
          if (token == null) {
            navigateToAndFinish(context: context, screen: LoginScreen());
          } else {
            navigateToAndFinish(context: context, screen: ShopLayout());
          }
        }
      });
    });
  }

/*   if (state is NavigateHome) {
              navigateToAndFinish(context: context, screen: ShopLayout());
            } else if (state is NavigateLogin) {
              MainCubit.get(context).endOnBoarding(context);
            } else if (state is NavigateOnBoarding) {
              //do nothing we are already on on boarding screen
            }*/
  void endOnBoarding(BuildContext context) {
    CacheHelper.setData(key: 'showOnBoarding', value: false).then((value) {
      navigateToAndFinish(context: context, screen: LoginScreen());
    });

    print('endOnBoarding');
  }
}
