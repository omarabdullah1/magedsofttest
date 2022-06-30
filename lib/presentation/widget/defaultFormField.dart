import 'package:flutter/material.dart';
import '../styles/colors.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  ValueChanged<String>? onChange,
  Function? onTap,
  bool isPassword = false,
  bool isValidate = false,
  bool isPrefixText = false,
  Function? validate,
  required String label,
  required prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
  double borderRadius = 20.0,
  double fontSize = 16.0,
}) =>
    TextFormField(
      style: TextStyle(fontSize: fontSize),
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted:(_)=> onSubmit!(_),
      onChanged: onChange,
      onTap:()=> onTap,
      validator: (_)=>validate!(_),
      decoration: InputDecoration(
        disabledBorder: OutlineInputBorder(
          borderSide:  const BorderSide(
            color: AppColor.primary,
            width: 2.5,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColor.error,
            width: 2.5,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColor.error,
            width: 2.5,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        labelText: label,
        labelStyle: TextStyle(fontSize: fontSize),
        prefixIcon: isPrefixText
            ? prefix
            : Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed:(){
            suffixPressed!();
          },
          icon: Icon(
            suffix,
          ),
        )
            : null,
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black26,
              width: 2.5,
            ),
            borderRadius: BorderRadius.circular(borderRadius)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColor.primary,
            width: 2.5,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );