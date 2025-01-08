import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/api/exceptions.dart';
import '../../../../core/cache/cache_helper.dart';
import '../../data/models/login_response_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final ApiConsumer api;
  AuthCubit(this.api) : super(AuthInitial());

  final TextEditingController loginEmail = TextEditingController();
  final TextEditingController loginPassword = TextEditingController();
  final TextEditingController signupName = TextEditingController();
  final TextEditingController signupEmail = TextEditingController();
  final TextEditingController signupPassword = TextEditingController();
  final TextEditingController signupConfirmPassword = TextEditingController();

  login() async {
    emit(LoginLoading());
    try {
      final response = await api.post(EndPoint.login, data: {
        ApiKeys.email: loginEmail.text,
        ApiKeys.password: loginPassword.text
      });
      final user = LoginResponseModel.fromJson(response);
      final token = user.token;
      debugPrint(token);
      debugPrint(user.name);
      await CacheHelper.saveSecuredString(key: ApiKeys.token, value: token!);
      await CacheHelper.saveData(key: ApiKeys.name, value: user.name);
      await CacheHelper.saveData(key: ApiKeys.email, value: user.email);
      debugPrint(CacheHelper.getData(key: user.name!));
      emit(LoginSuccess());
    } on ServerException catch (e) {
      emit(LoginFailure(e.errModel.errorMessage));
    }
  }

  signup() async {
    emit(SignUpLoading());
    try {
      await api.post(EndPoint.register, data: {
        ApiKeys.name: signupName.text,
        ApiKeys.email: signupEmail.text,
        ApiKeys.password: signupPassword.text,
      });
      emit(SignUpSuccess());
    } on ServerException catch (e) {
      emit(SignUpFailure(e.errModel.errorMessage));
    }
  }

  void clearSignupControllers() {
    signupName.clear();
    signupEmail.clear();
    signupPassword.clear();
    signupConfirmPassword.clear();
  }
}
