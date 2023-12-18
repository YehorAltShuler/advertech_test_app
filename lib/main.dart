import 'package:advertech_test_task/constants/app_colors.dart';
import 'package:advertech_test_task/providers/form_provider.dart';
import 'package:advertech_test_task/screens/contact_us_screen.dart';
import 'package:advertech_test_task/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FormProvider(apiService: ApiService()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Advertech Test Task',
        theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              disabledForegroundColor: AppColors.white,
              disabledBackgroundColor: AppColors.purpleMountainMajesty,
              foregroundColor: AppColors.white,
              backgroundColor: AppColors.purple,
            ),
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.seedColor),
          useMaterial3: true,
        ),
        home: const ContactUsScreen(),
      ),
    );
  }
}
