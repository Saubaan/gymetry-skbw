import 'package:flutter/material.dart';
import 'package:skbwmember/components/primary_button.dart';
import 'package:skbwmember/features/auth/presentation/components/auth_text_field.dart';
import 'package:skbwmember/features/member/domain/entities/member.dart';

class EditProfilePage extends StatefulWidget {
  final Member member;
  const EditProfilePage({super.key, required this.member});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final globalKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  // name validator
  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    } else if (value.length < 3) {
      return 'Name must be at least 3 characters';
    } else if (value.length > 50) {
      return 'Name must be at most 50 characters';
    } else if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
      return 'Name must contain only alphabets';
    }
    return null;
  }

  // phone validator
  String? phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone is required';
    } else if (value.length != 10) {
      return 'Phone must be 10 digits long';
    } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Phone must contain only numbers';
    }
    return null;
  }

  void updateProfile() {
    if (globalKey.currentState!.validate()) {
    }
  }

  @override
  Widget build(BuildContext context) {
    nameController.text = widget.member.name;
    phoneController.text = widget.member.phone;

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Center(
        child: Form(
          key: globalKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AuthTextField(
                controller: nameController,
                hintText: 'Name',
                validator: nameValidator,
                keyBoardType: TextInputType.name,
              ),
              SizedBox(height: 5,),

              AuthTextField(
                controller: phoneController,
                hintText: 'Phone',
                validator: phoneValidator,
                keyBoardType: TextInputType.phone,
              ),
              SizedBox(height: 5,),

              PrimaryButton(
                text: 'Save',
                onTap: updateProfile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
