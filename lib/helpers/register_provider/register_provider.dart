

import 'package:provider/provider.dart';

import '../../providers/sign_in_provider.dart';

var registerProvider = [
  ChangeNotifierProvider<SignInProvider>(
    create: ((context) => SignInProvider()),
  ),

];
