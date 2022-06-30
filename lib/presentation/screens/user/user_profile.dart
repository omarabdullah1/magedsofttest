import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../business_logic/app_localization.dart';
import '../../../business_logic/global_cubit/global_cubit.dart';
import '../../../data/local/cache_helper.dart';
import '../../styles/colors.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  void initState() {
    GlobalCubit.get(context).loginModel ??
        GlobalCubit.get(context).userLogin(
          email: CacheHelper.getDataFromSharedPreference(key: 'email'),
          password: CacheHelper.getDataFromSharedPreference(key: 'password'),
          context: context,
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var bloc = GlobalCubit.get(context);
    return BlocConsumer<GlobalCubit, GlobalState>(
      listener: (context, state) {},
      builder: (context, state) {
        return bloc.loginModel != null
            ? Scaffold(
                appBar: AppBar(
                  title: Text(AppLocalizations.of(context)!
                      .translate('userData')
                      .toString()),
                  centerTitle: true,
                ),
                body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                        Text(
                          AppLocalizations.of(context)!
                                  .translate('fullName')
                                  .toString() +
                              ': ' +
                              bloc.loginModel!.account!.first.name.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: AppColor.primary),
                        ),
                        Text(
                          AppLocalizations.of(context)!
                                  .translate('email')
                                  .toString() +
                              ': ' +
                              bloc.loginModel!.account!.first.email.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: AppColor.primary),
                        ),
                        Text(
                          AppLocalizations.of(context)!
                                  .translate('phone')
                                  .toString() +
                              ': ' +
                              bloc.loginModel!.account!.first.phone.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: AppColor.primary),
                        ),
                        const Expanded(child: SizedBox()),
                        Center(
                          child: SizedBox(
                            height: 60,
                            width: MediaQuery.of(context).size.width * 0.385,
                            child: MaterialButton(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              onPressed: () {
                                CacheHelper.removeData(key: 'id');
                                CacheHelper.removeData(key: 'email');
                                CacheHelper.removeData(key: 'password');
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  '/login',
                                  (route) => false,
                                );
                              },
                              child: Text(
                                AppLocalizations.of(context)!
                                    .translate('logout')
                                    .toString(),
                                style: const TextStyle(color: AppColor.white),
                              ),
                              color: AppColor.logoutButton,
                              elevation: 5.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
      },
    );
  }
}
