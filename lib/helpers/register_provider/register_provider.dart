

import 'package:provider/provider.dart';
import 'package:zavisoft_task/providers/home_provider.dart';

import '../../providers/sign_in_provider.dart';

var registerProvider = [
  ChangeNotifierProvider<SignInProvider>(
    create: ((context) => SignInProvider()),
  ),
  ChangeNotifierProvider<HomeProvider>(
    create: ((context) => HomeProvider()),
  ),

];
