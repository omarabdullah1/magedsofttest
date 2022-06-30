import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/end_points.dart';
import '../../data/local/cache_helper.dart';
import '../../data/models/account_model.dart';
import '../../data/models/registerModel.dart';
import '../../data/remote/dio_helper.dart';
import '../../main.dart';
import '../../presentation/widget/toast.dart';
import '../app_localization.dart';
part 'global_state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  GlobalCubit() : super(GlobalInitial());

  static GlobalCubit get(context) => BlocProvider.of(context);
  AccountModel? loginModel;
  RegisterModel? registerModel;

  bool isEnglish = CacheHelper.getDataFromSharedPreference(key: 'lang') == 'en'
      ? true
      : false;

  void userLogin(
      {required String email, required String password, required context}) {
    emit(LoginLoadingState());

    DioHelper.postData(
      url: LOGIN,
      body: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      log(value.data.toString());
      loginModel = AccountModel.fromJson(value.data);
      log(loginModel!.account!.first.name.toString());
      CacheHelper.saveDataSharedPreference(
        key: 'id',
        value: loginModel!.account!.first.id,
      );
      fToast.init(context);
      showToast(AppLocalizations.of(context)!
          .translate('loginSuccessfully')
          .toString());
      emit(LoginSuccessState(loginModel!));
    }).catchError((error) {
      log(error.toString());
      fToast.init(context);
      showToast(AppLocalizations.of(context)!
          .translate('pleaseCheckUsernameAndPassword')
          .toString());
      emit(LoginErrorState(error.toString()));
    });
  }

  void userRegister(
      {required String name,
      required String email,
      required String password,
      required String phone,
      required context}) {
    emit(RegisterLoadingState());

    DioHelper.postData(
      url: REGISTER,
      body: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    ).then((value) {
      registerModel = RegisterModel.fromJson(value.data);
      log(value.data.toString());
      log(registerModel!.status.toString());
      fToast.init(context);
      showToast(registerModel!.message);
      emit(RegisterSuccessState());
    }).catchError((error) {
      log(error.toString());
      log(error.toString());
      fToast.init(context);
      showToast(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }

  changeLanguageValue(context) async {
    delegate.changeLocale(delegate.currentLocale.languageCode == 'ar'
        ? const Locale('en')
        : const Locale('ar'));
    emit(AppChangeLanguageState());
  }
}
