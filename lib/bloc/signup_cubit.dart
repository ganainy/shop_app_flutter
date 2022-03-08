import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app_flutter/models/signup_model.dart';
import 'package:shop_app_flutter/network/cache_helper.dart';
import 'package:shop_app_flutter/network/dio_helper.dart';
import 'package:shop_app_flutter/network/endpoints.dart';
import 'package:shop_app_flutter/shared/constants.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupStates> {
  SignupCubit() : super(SignupInitial());
  bool isPasswordVisible = false;

  static SignupCubit get(context) => BlocProvider.of(context);

  changePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(PasswordVisibility());
  }

  register(
      {required String email,
      required String password,
      required String phone,
      required String name}) {
    emit(SignupLoading());
    DioHelper.postData(path: REGISTER, data: {
      'email': email,
      'password': password,
      'name': name,
      'phone': phone
    }).then((value) {
      SignupModel signupModel = SignupModel.fromJson(value.data);

      if (signupModel.status) {
        Shared.TOKEN = signupModel.data!.token;
        CacheHelper.setData(key: 'token', value: signupModel.data?.token)
            .then((value) {
          emit(SignupSuccess());
        });
      } else {
        emit(SignupError(signupModel.message));
      }
    }).catchError((error) {
      emit(SignupError(error.toString()));
      //print(error.toString());
    });
  }
}
