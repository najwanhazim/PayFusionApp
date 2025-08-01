import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pay_fusion/pages/budget_donut_page.dart';
import 'package:pay_fusion/enum/current_view_enum.dart';
import 'package:pay_fusion/pages/business/business_form.dart';
import 'package:pay_fusion/pages/charity/charity_form.dart';
import 'package:pay_fusion/pages/charity/charity_list.dart';
import 'package:pay_fusion/pages/intro/intro_page.dart';
import 'package:pay_fusion/pages/invoice_page.dart';

//global variable for view, for easy navigation later on
//kan ada button for user/business/charity view, kita boleh set global variable ni
CurrentViewEnum currentView = CurrentViewEnum.user;
bool hasIsiBusiness = false;
bool hasIsiCharity = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.grey,
        scaffoldBackgroundColor: Colors.grey[900],
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.grey,
          brightness: Brightness.dark,
        ),
      ),
      home: IntroPage(),
    );
  }
}
