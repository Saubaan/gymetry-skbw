import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skbwmember/features/auth/domain/entities/pending_member.dart';
import 'package:skbwmember/features/auth/presentation/components/auth_text_field.dart';
import 'package:skbwmember/components/primary_button.dart';
import 'package:skbwmember/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:skbwmember/theme/app_font.dart';
import 'package:skbwmember/utils/app_snack_bar.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  List<String> subscriptions = ['1 Month', '3 Months', '6 Months', '1 Year'];
  List<int> durations = [30, 90, 180, 365];
  int selectedDuration = 0;
  bool isObscure = true;

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name cannot be empty';
    }
    final nameRegex = RegExp(r'^[a-zA-Z\s.-]+$');
    if (!nameRegex.hasMatch(value)) {
      return 'Enter a valid name';
    }
    return null;
  }

  // validate email
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  // validate password length 6 characters
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    final passwordRegex = RegExp(r'^[a-zA-Z0-9@!#$%^&*]{6,}$');
    if (!passwordRegex.hasMatch(value)) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  // validate confirm password
  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    } else if (passwordController.text != value) {
      return 'Passwords do not match';
    }
    return null;
  }

  // validate phone number
  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number cannot be empty';
    }
    final phoneRegex = RegExp(r'^[0-9]{10}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  void register() async {
    final email = emailController.text;
    final password = passwordController.text;
    final name = nameController.text;
    final phone = phoneController.text;

    if (formKey.currentState!.validate()) {
      final authCubit = context.read<AuthCubit>();

      final createdAt = DateTime.now();
      final expiryDate =
          DateTime.now().add(Duration(days: durations[selectedDuration]));

      final member = PendingMember(
        name: name,
        email: email,
        phone: phone,
        password: password,
        createdAt: createdAt,
        expiryDate: expiryDate,
      );
      // Authentication
      await authCubit.register(member);
    } else {
      AppSnackBar.showError(
          'Please fill out the details correctly.', context);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sWidth = MediaQuery.of(context).size.width;
    final sHeight = MediaQuery.of(context).size.height;
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: theme.surface,
      body: SingleChildScrollView(
        child: Container(
          height: sHeight,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                theme.secondary.withAlpha(10),
                theme.secondary.withAlpha(5),
                theme.primary.withAlpha(-150),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(sWidth / 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// Login Form Container
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Login Text
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Login
                          Text(
                            'Register',
                            style: TextStyle(
                              color: theme.onSurface,
                              fontSize: sWidth / 12,
                              fontFamily: AppFont.primaryFont,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: sHeight / 100),

                      /// Login Form
                      Container(
                        padding: EdgeInsets.all(sWidth / 40),
                        decoration: BoxDecoration(
                            color: theme.onSurface.withAlpha(100),
                            borderRadius: BorderRadius.circular(sWidth / 20)),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              /// Name Field
                              AuthTextField(
                                hintText: 'Name',
                                controller: nameController,
                                keyBoardType: TextInputType.name,
                                validator: validateName,
                                onSubmit: (_) =>
                                    {formKey.currentState!.validate()},
                              ),

                              SizedBox(height: sHeight / 100),

                              /// Phone Field
                              AuthTextField(
                                hintText: 'Phone',
                                controller: phoneController,
                                keyBoardType: TextInputType.phone,
                                validator: validatePhone,
                                onSubmit: (_) =>
                                    {formKey.currentState!.validate()},
                              ),

                              SizedBox(height: sHeight / 100),

                              /// E-mail Field
                              AuthTextField(
                                hintText: 'E-mail',
                                controller: emailController,
                                validator: validateEmail,
                                keyBoardType: TextInputType.emailAddress,
                                onSubmit: (_) =>
                                    {formKey.currentState!.validate()},
                              ),

                              SizedBox(height: sHeight / 100),

                              /// Password Field
                              AuthTextField(
                                hintText: 'Set Password',
                                controller: passwordController,
                                isObscure: isObscure,
                                onPressed: () {
                                  setState(
                                    () {
                                      isObscure = !isObscure;
                                    },
                                  );
                                },
                                validator: validatePassword,
                              ),

                              SizedBox(height: sHeight / 100),

                              /// Confirm Password Field
                              AuthTextField(
                                hintText: 'Confirm Password',
                                controller: confirmPasswordController,
                                validator: validateConfirmPassword,
                                onSubmit: (_) =>
                                    {formKey.currentState!.validate()},
                              ),

                              SizedBox(height: sHeight / 100),

                              Container(
                                padding: EdgeInsets.all(sWidth / 40),
                                decoration: BoxDecoration(
                                  color: theme.surface.withAlpha(200),
                                  borderRadius:
                                      BorderRadius.circular(sWidth / 40),
                                  border:
                                      Border.all(color: Colors.grey.shade400),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Duration: ',
                                      style: TextStyle(
                                        color: theme.onSurface.withAlpha(150),
                                        fontSize: sWidth / 26,
                                        fontFamily: AppFont.primaryFont,
                                      ),
                                    ),
                                    DropdownButton<int>(
                                      underline: Container(),
                                      style: TextStyle(
                                        color: theme.onSurface,
                                        fontFamily: AppFont.primaryFont,
                                      ),
                                      value: selectedDuration,
                                      items: subscriptions
                                          .asMap()
                                          .entries
                                          .map(
                                            (e) => DropdownMenuItem<int>(
                                              value: e.key,
                                              child: Text(e.value),
                                            ),
                                          )
                                          .toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedDuration = value!;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: sHeight / 100),

                              /// Register Button
                              PrimaryButton(
                                text: 'Register',
                                onTap: register,
                                color: theme.primary,
                                textColor: theme.onPrimary,
                              ),

                              SizedBox(height: sHeight / 100),

                              /// Login Button
                              PrimaryButton(
                                text: 'Already a member?',
                                onTap: widget.onTap,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  /// Gym Name Text
                  Column(
                    children: [
                      Text(
                        'made for',
                        style: TextStyle(
                          color: theme.onSurface.withAlpha(100),
                          fontSize: sWidth / 30,
                          fontFamily: AppFont.primaryFont,
                        ),
                      ),
                      Text(
                        'S. K. Body Care',
                        style: TextStyle(
                          color: theme.onSurface,
                          fontSize: sWidth / 24,
                          fontFamily: AppFont.primaryFont,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
