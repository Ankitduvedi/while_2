import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as river;
import 'package:provider/provider.dart';
import 'package:while_app/repository/firebase_repository.dart';
import 'package:while_app/resources/components/message/apis.dart';
import 'package:while_app/utils/data_provider.dart';
import 'package:while_app/utils/routes/routes_name.dart';
import 'package:while_app/view_model/current_user_provider.dart';
import 'package:while_app/view_model/firebasedata.dart';
import 'package:while_app/view_model/post_provider.dart';
import 'package:while_app/view_model/profile_controller.dart';
import 'utils/routes/routes.dart';
import 'view_model/reel_controller.dart';
import 'firebase_options.dart';

final userProvider = river.StreamProvider((ref) {
  return FirebaseFirestore.instance
      .collection('users')
      .doc(APIs.me.id)
      .snapshots();
});
late Size mq;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setEnabledSystemUIMode(
  //   SystemUiMode.manual,
  //   overlays: [
  //     SystemUiOverlay.top,
  //   ],
  // );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  APIs.getSelfInfo();
  Provider.debugCheckInvalidValueType = null;
  runApp(const river.ProviderScope(child: MyApp()));
}

class MyApp extends river.ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, river.WidgetRef ref) {
    mq = MediaQuery.of(context).size;
    SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
        // systemNavigationBarIconBrightness: Brightness.light,
        // systemNavigationBarColor: Colors.transparent,
        // systemNavigationBarDividerColor: Colors.transparent,
        // systemNavigationBarContrastEnforced: false,
        systemStatusBarContrastEnforced: false);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    //     overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
    //     overlays: [SystemUiOverlay.bottom]);
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    return MultiProvider(
      providers: [
        Provider(create: (_) => PostProvider()),
        Provider<FirebaseAuthMethods>(
            create: (_) => FirebaseAuthMethods(FirebaseAuth.instance)),
        Provider<ReelController>(create: (_) => ReelController()),
        StreamProvider(
            create: (context) => context.read<FirebaseAuthMethods>().authState,
            initialData: null),
        ChangeNotifierProvider(create: (_) => ProfileController()),
        Provider(create: (_) => CurrentUserProvider()),
        Provider(
          create: (_) => FireBaseDataProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DataProvider(),
        )
      ],
      child: const MaterialApp(
        title: 'While',
        debugShowCheckedModeBanner: false,
        initialRoute: RoutesName.wrapper,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
