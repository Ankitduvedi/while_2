import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:while_app/resources/components/classroom/classroom_home_screen.dart';
import 'package:while_app/theme/pallete.dart';
import 'package:while_app/view/social/social_home_screen.dart';

class FeedScreen extends ConsumerStatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);
  @override
  ConsumerState<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends ConsumerState<FeedScreen> {
  void themeToggler(WidgetRef ref) {
    ref.read(themeNotifierProvider.notifier).toggleTheme();
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = ref.watch(themeNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: currentTheme.scaffoldBackgroundColor,
        elevation: 0.0,
        actions: [
          // Switch.adaptive(
          //   value: ref.watch(themeNotifierProvider.notifier).mode ==
          //       ThemeMode.light,
          //   onChanged: (value) => themeToggler(ref),
          // ),
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ClassroomScreen(),
                ));
              },
              icon: const Icon(
                Icons.menu_book,
                color: Colors.black,
              )),
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const SocialScreen(),
                ));
              },
              icon: const Icon(
                Icons.message,
                color: Colors.black,
              )),
        ],
      ),
      body: const Center(
          child: Text("Coming soon...",
              style: TextStyle(
                fontSize: 30,
              ))),
    );
  }
}
