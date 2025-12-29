import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField(
      {Key? key,
      this.textInputAction,
      required this.hintText,
      this.controller,
      this.isImportantStarLabelRequired = true,
      this.labelHeading,
      this.obscureText,
      this.isFixedlabel = true,
      this.height,
      this.inputFormatters,
      this.isDense = true,
      this.readOnly,
      this.focusNode,
      this.autofocus,
      this.maxLength,
      this.maxLines,
      this.onChanged,
      this.onTap,
      this.keyboardType,
      this.isSuffixIconRequired = false,
      this.suffixIcon,
      this.onSubmittedRequired = false})
      : super(key: key);

  final double? height;
  final int? maxLength;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final String hintText;
  final TextEditingController? controller;
  final bool? readOnly;
  final bool? isImportantStarLabelRequired;
  final bool? obscureText;
  final bool? isFixedlabel;
  final bool? isDense;
  final bool? onSubmittedRequired;

  final bool? autofocus;
  final bool? isSuffixIconRequired;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final Widget? suffixIcon;

  final String? labelHeading;

  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: autofocus ?? false,
      focusNode: focusNode,
      maxLength: maxLength,
      maxLines: maxLines ?? 1,
      readOnly: readOnly ?? false,
      keyboardType: keyboardType ?? TextInputType.text,
      textInputAction: textInputAction ?? TextInputAction.next,
      controller: controller,
      obscureText: obscureText ?? false,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      onSubmitted: onSubmittedRequired == true
          ? (_) => FocusScope.of(context).nextFocus()
          : null,
      // style: baseTextTheme.hintValueTextStyle,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        suffixIcon: isSuffixIconRequired == true
            ? Padding(
                padding: const EdgeInsets.only(right: 10),
                child: suffixIcon,
              )
            : null,
        suffixIconConstraints:
            const BoxConstraints(minWidth: 20, minHeight: 20),
        // errorStyle: baseTextTheme.loginTextFieldFloatingLabelStarTextStyle
        //     .copyWith(overflow: TextOverflow.visible),
        hintText: hintText,
        isDense: isDense ?? true,
        // hintStyle: baseTextTheme.loginTextFieldHintTextStyle,
        floatingLabelBehavior:
            isFixedlabel == true ? FloatingLabelBehavior.always : null,
        label: labelHeading != null
            ? RichText(
                text: TextSpan(children: [
                TextSpan(
                  text: labelHeading,
                  // style: baseTextTheme.loginTextFieldFloatingLabelTextStyle,
                ),
                if (isImportantStarLabelRequired == true)
                  const TextSpan(
                    text: " *",
                    // style: baseTextTheme
                    //     .loginTextFieldFloatingLabelStarTextStyle),
                  )
              ]))
            : null,
        // labelStyle: baseTextTheme.hintValueTextStyle,
        floatingLabelStyle:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor)),
      ),
    );
  }
}

class CommonTextFormField extends StatelessWidget {
  const CommonTextFormField(
      {Key? key,
      this.initialValue,
      this.focusNode,
      this.height,
      this.maxLength,
      this.maxLines,
      this.textInputAction,
      required this.hintText,
      this.controller,
      this.readOnly,
      this.isImportantStarLabelRequired,
      this.obscureText,
      this.isFixedlabel,
      this.isDense,
      this.onSubmittedRequired,
      this.autofocus,
      this.isSuffixIconRequired,
      this.keyboardType,
      this.onChanged,
      this.onTap,
      this.suffixIcon,
      this.labelHeading,
      this.inputFormatters,
      this.errorText,
      this.isfilled = false,
      this.textAlign,
      this.textAlignVertical,
      this.hintStyle,
      this.customDateError,
      this.isMobileValidationRequired,
      this.isEmailValidationRequired,
      this.isPasswordValidationRequired,
      this.compareWithcontroller,
      this.compareWithPrevious = false,
      this.compareErrorText})
      : super(key: key);

  final String? initialValue;
  final FocusNode? focusNode;
  final TextAlign? textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextStyle? hintStyle;
  final double? height;
  final int? maxLength;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final String hintText;
  final String? errorText;
  final String? compareErrorText;
  final TextEditingController? controller;
  final TextEditingController? compareWithcontroller;
  final bool? readOnly;
  final bool? isImportantStarLabelRequired;
  final bool? obscureText;
  final bool? isFixedlabel;
  final bool? isDense;
  final bool? onSubmittedRequired;
  final bool? isfilled;
  final bool? isMobileValidationRequired;
  final bool? isEmailValidationRequired;
  final bool? isPasswordValidationRequired;
  final bool? customDateError;

  final bool? autofocus;
  final bool? compareWithPrevious;
  final bool? isSuffixIconRequired;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final Widget? suffixIcon;

  final String? labelHeading;

  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    // final themeViewModel = context.watch<ThemeViewModel>();
    // final baseTextTheme = themeViewModel.baseTextTheme;
    // final baseColorTheme = themeViewModel.colors;
    bool error = false;
    return TextFormField(
      initialValue: initialValue,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autofocus: autofocus ?? false,
      focusNode: focusNode,
      maxLength: maxLength,
      maxLines: maxLines ?? 1,
      readOnly: readOnly ?? false,
      onTap: onTap,
      keyboardType: keyboardType ?? TextInputType.text,
      textInputAction: textInputAction ?? TextInputAction.next,
      controller: controller,
      obscureText: obscureText ?? false,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      onFieldSubmitted: onSubmittedRequired == true
          ? (_) => FocusScope.of(context).nextFocus()
          : null,
      // style: baseTextTheme.hintValueTextStyle,
      textCapitalization: TextCapitalization.sentences,
      textAlign: textAlign ?? TextAlign.start,
      textAlignVertical: textAlignVertical,
      decoration: InputDecoration(
          // fillColor: baseColorTheme.primaryColor,
          // focusColor:  Colors.white,
          errorMaxLines: 2,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          suffixIcon: isSuffixIconRequired == true ? suffixIcon : null,
          suffixIconConstraints:
              const BoxConstraints(minWidth: 20, minHeight: 20),
          // helperText: " ",
          // helperStyle: const TextStyle(fontSize: 0),

          isDense: true,
          hintText: hintText,
          // hintStyle: hintStyle ?? baseTextTheme.loginTextFieldHintTextStyle,
          errorStyle: const TextStyle(
            fontSize: 13,
            // fontFamily: 'Avenir',
            // color: baseColorTheme.textFieldFloatingLabelStarColor
          ),

          // errorStyle: focusNode.hasFocus
          //     ? const TextStyle(fontSize: 0, height: 0)
          //     : TextStyle(
          //         fontSize: 13,
          //         fontFamily: 'Avenir',
          //         color: baseColorTheme.textFieldFloatingLabelStarColor),

          floatingLabelBehavior:
              isFixedlabel == true ? FloatingLabelBehavior.always : null,
          label: labelHeading != null
              ? RichText(
                  text: TextSpan(children: [
                  TextSpan(
                    text: labelHeading,
                    // style: baseTextTheme.loginTextFieldFloatingLabelTextStyle,
                  ),
                  if (isImportantStarLabelRequired == true)
                    const TextSpan(
                      text: " *",
                      // style: baseTextTheme
                      //     .loginTextFieldFloatingLabelStarTextStyle),
                    )
                ]))
              : null,
          focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  // color: baseColorTheme.textFieldFloatingLabelStarColor
                  )),
          errorBorder: (controller != null && controller!.text.isNotEmpty)
              ? null
              : const OutlineInputBorder(
                  borderSide: BorderSide(
                      // color: baseColorTheme.textFieldFloatingLabelStarColor
                      )),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor))),
      validator: (value) {
        value!.trim().isNotEmpty ? error = !error : error = error;
        if (customDateError == true) {
          if (value.toLowerCase() == hintText.toLowerCase()) {
            return errorText;
          }
        }
        if (value.isEmpty) {
          return errorText;
        }
        if (compareWithPrevious == true) {
          if (compareWithcontroller != null) {
            if (value != compareWithcontroller!.text) {
              return compareErrorText ??
                  'Make sure your field matches with above';
            }
          }
        }
        if (isMobileValidationRequired == true) {
          if (value.length > 10 || value.length < 10) {
            return "Please Enter Valid Mobile Number";
          }
        }

        if (isEmailValidationRequired == true) {
          if (!RegExp(
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
              .hasMatch(value)) {
            return "Please Enter Valid Email ID";
          }
        }
        if (isPasswordValidationRequired == true) {
          if (!RegExp(
                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$')
              .hasMatch(value)) {
            return "Please enter a strong password of atleast 6 characters ( for eg. Name@1234 )";
          }
        }
        return null;
      },
    );
  }
}
