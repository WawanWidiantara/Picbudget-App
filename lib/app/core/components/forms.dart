import 'package:flutter/services.dart';
import 'package:picbudget_app/app/core/constants/text_styles.dart';
import 'package:picbudget_app/app/core/styles/form_styles.dart';
import 'package:flutter/material.dart';
import 'package:picbudget_app/app/modules/auth/controllers/otp_controller.dart';

class FormWidget extends StatelessWidget {
  const FormWidget({
    super.key,
    required this.controller,
    required this.label,
    required this.validator,
    required this.isObsecured,
    required this.keyboardType,
    required this.hintText,
    required this.onChanged,
  });

  final TextEditingController controller;
  final String label;
  final String? Function(String?) validator;
  final bool isObsecured;
  final TextInputType keyboardType;
  final String hintText;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTypography.titleSmall),
        const SizedBox(height: 8),
        SizedBox(
          child: TextFormField(
            controller: controller,
            validator: validator,
            obscureText: isObsecured,
            keyboardType: keyboardType,
            style: AppTypography.bodyMedium,
            decoration: formStyle(hintText),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

class OTPForm extends StatelessWidget {
  const OTPForm({
    super.key,
    required this.controller,
  });

  final OtpController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: TextFormField(
        controller: controller.otpController,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 6,
        style: AppTypography.headlineMedium.copyWith(
          fontWeight: FontWeight.bold,
        ),
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp(r'\s')), // Restrict spaces
        ],
        decoration: otpFormStyle(),
        onTapOutside: (value) {
          FocusScope.of(context).unfocus();
        },
        onChanged: (value) {
          if (value.length == 6) {
            // Automatically submit when 6 characters are entered
            FocusScope.of(context).unfocus(); // Close the keyboard
            controller
                .verifyOtp(); // Call the controller's OTP submission method
          }
        },
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter OTP';
          }
          return null;
        },
      ),
    );
  }
}
