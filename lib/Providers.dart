import 'dart:js_interop';

import 'package:provider/provider.dart';

import 'Application/StudentProviders/LoginProvider.dart';

List providerrr =[];

void provider(){


  providerrr.add(
    ChangeNotifierProvider(create: (context) => LoginProvider()),

  );





}