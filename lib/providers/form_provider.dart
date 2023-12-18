import 'package:advertech_test_task/services/api_service.dart';
import 'package:advertech_test_task/services/api_service_interface.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class FormProvider extends ChangeNotifier {
  FormProvider({required this.apiService});
  final ApiServiceInterface apiService;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  FocusNode nameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode messageFocusNode = FocusNode();

  Response? _response;

  Response? get response {
    return _response;
  }

  bool _isSending = false;

  bool get isSending => _isSending;

  bool _isButtonDisabled = true;

  bool get isButtonDisabled => _isButtonDisabled;

  void setIsSending(bool value) {
    _isSending = value;
    notifyListeners();
  }

  void resetForm() {
    nameController.clear();
    emailController.clear();
    messageController.clear();
    setIsSending(false);
  }

  Future<Response> submitForm() async {
    if (formKey.currentState!.validate()) {
      setIsSending(true);
      final response = await ApiService().sendDataToServer(
        name: nameController.text,
        email: emailController.text,
        message: messageController.text,
      );
      return response;
    } else {
      throw Exception();
    }
  }

  bool _isFormValid() {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        messageController.text.isNotEmpty &&
        emailRegex.hasMatch(emailController.text);
  }

  void disableButton() {
    _isButtonDisabled = true;
    notifyListeners();
  }

  void updateButtonState() {
    _isButtonDisabled = !_isFormValid();
    notifyListeners();
  }
}
