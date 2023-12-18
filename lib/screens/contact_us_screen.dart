import 'package:advertech_test_task/constants/app_colors.dart';
import 'package:advertech_test_task/providers/form_provider.dart';
import 'package:advertech_test_task/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back),
        title: const Text('Contact Us'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Consumer<FormProvider>(
            builder: (context, formProvider, _) => Form(
              key: formProvider.formKey,
              onChanged: () => formProvider.updateButtonState(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  CustomFormField(
                    key: const Key('name_field'),
                    controller: formProvider.nameController,
                    labelText: 'Name',
                    focusNode: formProvider.nameFocusNode,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context)
                          .requestFocus(formProvider.emailFocusNode);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  CustomFormField(
                    key: const Key('email_field'),
                    controller: formProvider.emailController,
                    labelText: 'Email',
                    focusNode: formProvider.emailFocusNode,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context)
                          .requestFocus(formProvider.messageFocusNode);
                    },
                    validator: (email) {
                      final emailRegex =
                          RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                      if (email == null || email.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!emailRegex.hasMatch(email)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  CustomFormField(
                    key: const Key('message_field'),
                    controller: formProvider.messageController,
                    labelText: 'Message',
                    focusNode: formProvider.messageFocusNode,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a message';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 90.0),
                  ElevatedButton(
                    key: const Key('send_button'),
                    onPressed: formProvider.isButtonDisabled
                        ? null
                        : () {
                            formProvider.disableButton();
                            formProvider.submitForm().then(
                              (result) {
                                if (result.statusCode == 201) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Done!'),
                                      backgroundColor: AppColors.successColor,
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Something went wrong!'),
                                      backgroundColor: AppColors.errorColor,
                                    ),
                                  );
                                }
                                formProvider.setIsSending(false);
                                formProvider.updateButtonState();
                              },
                            );
                          },
                    child: formProvider.isSending
                        ? const Text('Please Wait')
                        : const Text('Send'),
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
