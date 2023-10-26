import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:while_app/theme/pallete.dart';
import 'package:while_app/view/create_screen.dart';
import 'package:while_app/view/feed_screen.dart';
import 'package:while_app/view/profile/user_profile_screen.dart';
import 'package:while_app/view/reels_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  // ignore: non_constant_identifier_names
  int CurrentIndex = 0;

  void onTapChange(int index) {
    setState(() {
      CurrentIndex = index;
    });
  }

  void themeToggler(WidgetRef ref) {
    ref.read(themeNotifierProvider.notifier).toggleTheme();
  }

  static final List<Widget> _widgetOptions = <Widget>[
    const FeedScreen(),
    const ReelsScreen(),
    const CreateScreen(),
    const ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    final currentTheme = ref.watch(themeNotifierProvider);
    return Scaffold(
      body: Stack(children: [
        Scaffold(
          extendBody: true,
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(0)),
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: GNav(
                  onTabChange: onTapChange,
                  activeColor: Colors.black,
                  tabBackgroundColor: currentTheme.primaryColor,
                  padding: const EdgeInsets.all(5),
                  tabs: const [
                    GButton(
                      iconColor: Colors.white,
                      icon: Icons.home,
                      text: 'Home',
                    ),

                    // textColor: currentTheme ==),
                    GButton(
                      iconColor: Colors.white,
                      icon: Icons.movie_creation_outlined,
                      text: 'Reels',
                      iconSize: 25,
                    ),
                    GButton(
                      iconColor: Colors.white,
                      icon: Icons.add,
                      text: 'Create',
                    ),
                    GButton(
                      iconColor: Colors.white,
                      icon: Icons.account_circle,
                      text: 'User Profile',
                    ),
                  ]),
            ),
          ),
          body: Center(
            child: _widgetOptions.elementAt(CurrentIndex),
          ),
        ),
      ]),
    );
  }
}
