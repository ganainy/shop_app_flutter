import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app_flutter/models/login_model.dart';
import 'package:shop_app_flutter/network/cache_helper.dart';
import 'package:shop_app_flutter/network/dio_helper.dart';
import 'package:shop_app_flutter/network/endpoints.dart';
import 'package:shop_app_flutter/shared/constants.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitial());

  bool isPasswordVisible = false;

  static LoginCubit get(context) => BlocProvider.of(context);

  changePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(PasswordVisibility());
  }

  login({required String email, required String password}) {
    emit(LoginLoading());
    DioHelper.postData(
        path: LOGIN,
        data: {'email': email, 'password': password}).then((value) {
      LoginModel loginModel = LoginModel.fromJson(value.data);
      //print('api resonse$loginModel');
      if (loginModel.status) {
        //print('token  ${loginModel.data?.token}');
        Shared.TOKEN = loginModel.data!.token;
        CacheHelper.setData(key: 'token', value: loginModel.data?.token)
            .then((value) {
          emit(LoginSuccess());
        });
      } else {
        emit(LoginError(loginModel.message));
      }
    }).catchError((error) {
      emit(LoginError(error.toString()));
      //print(error.toString());
    });
  }
}
