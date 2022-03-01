import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app_flutter/network/dio_helper.dart';
import 'package:shop_app_flutter/network/endpoints.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitial());

  bool isPasswordVisible = true;

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
      Map<String, dynamic>? response = value.data;
      print('api resonse$response');
      if (response != null && response['status'] == true) {
        emit(LoginSuccess());
      } else {
        emit(LoginError('error response'));
      }
    }).catchError((error) {
      emit(LoginError(error.toString()));
      print(error.toString());
    });
  }
}
