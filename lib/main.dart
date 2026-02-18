import 'package:a_and_i_admin_web_serivce/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aandi_auth/aandi_auth.dart';

import 'app/app.dart';
import 'app/env.dart';

void main() async {
  // ...

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    ProviderScope(
      overrides: [authBaseUrlProvider.overrideWith((ref) => AppEnv.apiBaseUrl)],
      child: const AdminApp(),
    ),
  );
}
