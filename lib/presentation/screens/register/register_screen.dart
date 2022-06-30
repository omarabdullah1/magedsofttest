import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../business_logic/app_localization.dart';
import '../../../business_logic/global_cubit/global_cubit.dart';
import '../../../data/local/cache_helper.dart';
import '../../styles/colors.dart';
import '../../widget/defaultFormField.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var phoneController = TextEditingController();

  var passwordController = TextEditingController();

  var confirmPasswordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var bloc = GlobalCubit.get(context);
    return BlocConsumer<GlobalCubit, GlobalState>(
      listener: (context, state) async {
        if (state is RegisterSuccessState) {
          if(bloc.registerModel!.status == 200) {
            CacheHelper.saveDataSharedPreference(
              key: 'email',
              value: emailController.text,
            );
            CacheHelper.saveDataSharedPreference(
              key: 'password',
              value: passwordController.text,
            );
            bloc.loginModel = null;
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/profile',
                  (route) => false,
            );
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColor.primary,
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.02,
                  child: SizedBox(
                    child: const Image(
                      image: AssetImage(
                        'assets/images/logo2.png',
                      ),
                    ),
                    height: MediaQuery.of(context).size.height * 0.22,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                  height: MediaQuery.of(context).viewInsets.bottom == 0
                      ? MediaQuery.of(context).size.height * 0.75
                      : MediaQuery.of(context).size.height * 0.40,
                  child: SingleChildScrollView(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40.0),
                          topLeft: Radius.circular(40.0),
                        ),
                      ),
                      height: MediaQuery.of(context).size.height * 0.75,
                      width: MediaQuery.of(context).size.width,
                      child: SingleChildScrollView(
                        child: Center(
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40.0),
                                  child: defaultFormField(
                                    controller: nameController,
                                    type: TextInputType.emailAddress,
                                    isValidate: true,
                                    borderRadius: 10,
                                    validate: (String value) {
                                      if (value.isEmpty) {
                                        return AppLocalizations.of(context)!.translate('pleaseEnterYourFullName').toString();
                                      }
                                    },
                                    label: AppLocalizations.of(context)!.translate('fullName').toString(),
                                    prefix: Icons.person_rounded,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40.0),
                                  child: defaultFormField(
                                    controller: emailController,
                                    type: TextInputType.emailAddress,
                                    isValidate: true,
                                    borderRadius: 10,
                                    validate: (String value) {
                                      if (value.isEmpty) {
                                        return AppLocalizations.of(context)!.translate('pleaseEnterYourEmailAddress').toString();
                                      }
                                    },
                                    label: AppLocalizations.of(context)!.translate('email').toString(),
                                    prefix: Icons.email_outlined,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40.0),
                                  child: defaultFormField(
                                    controller: phoneController,
                                    type: TextInputType.emailAddress,
                                    isValidate: true,
                                    borderRadius: 10,
                                    validate: (String value) {
                                      if (value.isEmpty) {
                                        return AppLocalizations.of(context)!.translate('pleaseEnterYourPhone').toString();
                                      }else if(value.length<11||value.length>15){
                                        return AppLocalizations.of(context)!.translate('phoneWrong').toString();
                                      }
                                    },
                                    label: AppLocalizations.of(context)!.translate('phone').toString(),
                                    prefix: Icons.phone_android,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40.0),
                                  child: defaultFormField(
                                    controller: passwordController,
                                    type: TextInputType.visiblePassword,
                                    suffix: GlobalCubit.get(context).suffix,
                                    isValidate: true,
                                    borderRadius: 10,
                                    isPassword:
                                        GlobalCubit.get(context).isPassword,
                                    suffixPressed: () {
                                      GlobalCubit.get(context)
                                          .changePasswordVisibility();
                                    },
                                    validate: (String value) {
                                      if (value.isEmpty) {
                                        return AppLocalizations.of(context)!.translate('pleaseEnterYourPassword').toString();
                                      }
                                    },
                                    label: AppLocalizations.of(context)!.translate('password').toString(),
                                    prefix: Icons.lock_outline,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40.0),
                                  child: defaultFormField(
                                    controller: confirmPasswordController,
                                    type: TextInputType.visiblePassword,
                                    suffix: GlobalCubit.get(context).suffix,
                                    isValidate: true,
                                    borderRadius: 10,
                                    onSubmit: (value) {
                                      if (formKey.currentState!.validate()) {
                                        GlobalCubit.get(context).userRegister(
                                          email: emailController.text,
                                          password: passwordController.text,
                                          name: nameController.text,
                                          phone: phoneController.text,
                                          context: context,
                                        );
                                      }
                                    },
                                    isPassword:
                                        GlobalCubit.get(context).isPassword,
                                    suffixPressed: () {
                                      GlobalCubit.get(context)
                                          .changePasswordVisibility();
                                    },
                                    validate: (String value) {
                                      if (value.isEmpty) {
                                        return AppLocalizations.of(context)!.translate('pleaseEnterYourPassword').toString();
                                      } else if (passwordController.text !=
                                          value) {
                                        return AppLocalizations.of(context)!.translate('passwordNotMatch').toString();
                                      }
                                    },
                                    label: AppLocalizations.of(context)!.translate('confirmPassword').toString(),
                                    prefix: Icons.lock_outline,
                                  ),
                                ),
                                // const Expanded(
                                //   child: SizedBox(),
                                // ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: ConditionalBuilder(
                                    condition: state is! RegisterLoadingState,
                                    fallback: (context) => const Center(
                                        child: CircularProgressIndicator()),
                                    builder: (context) => MaterialButton(
                                      height: 55,
                                      minWidth:
                                          MediaQuery.of(context).size.width / 3,
                                      elevation: 5.0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          GlobalCubit.get(context).userRegister(
                                            email: emailController.text,
                                            password: passwordController.text,
                                            name: nameController.text,
                                            phone: phoneController.text,
                                            context: context,
                                          );
                                        }
                                        // Navigator.push(context,MaterialPageRoute(builder: (context)=> RegisterScreen()));
                                      },
                                      child: Text(
                                        AppLocalizations.of(context)!.translate('register').toString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.white,
                                        ),
                                      ),
                                      color: AppColor.button,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
