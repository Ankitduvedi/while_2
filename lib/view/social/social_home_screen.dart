import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:while_app/resources/components/communities/add_community_widget.dart';
import 'package:while_app/resources/components/message/home_screen.dart';
import 'package:while_app/view/social/notification.dart';
import 'package:while_app/view/social/status_screen.dart';
import 'package:while_app/view/social/story_screen.dart';

import '../../resources/components/communities/community_home_screen.dart';

class SocialScreen extends StatefulWidget {
  const SocialScreen({
    super.key,
  });

  @override
  State<SocialScreen> createState() {
    return _SocialScreenState();
  }
}

class _SocialScreenState extends State<SocialScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  bool isSearching = false;
  bool isSearchingHasValue = false;
  var value = '';

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: WillPopScope(
          //if search is on & back button is pressed then close search
          //or else simple close current screen on back button click
          onWillPop: () {
            if (isSearching) {
              setState(() {
                isSearching = !isSearching;
              });
              return Future.value(false);
            } else {
              return Future.value(true);
            }
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: isSearching
                  ? TextField(
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Name, Email, ...',
                          hintStyle: TextStyle(
                            color: Color.fromARGB(142, 220, 216, 216),
                          )),
                      autofocus: true,
                      style: const TextStyle(
                          fontSize: 17,
                          letterSpacing: 0.5,
                          color: Colors.white),
                      //when search text changes then updated search list
                      onChanged: (val) {
                        //search logic
                        setState(() {
                          value = val;
                          isSearchingHasValue = isSearching;
                        });
                      },
                    )
                  : const Text(
                      'Social',
                      style: TextStyle(color: Colors.white),
                    ),
              actions: [
                IconButton(
                    onPressed: () {
                      AddCommunityScreen().addCommunityDialog(context);
                    },
                    icon: const Icon(
                      Icons.group_add,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => const NotificationScreen()));
                    },
                    icon: const Icon(
                      Icons.notifications,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () {
                      // Navigator.of(context)
                      //     .push(MaterialPageRoute(builder: (ctx) => const Search()));
                      setState(() {
                        isSearching = !isSearching;
                      });
                    },
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    )),
                PopupMenuButton(
                    color: Colors.white,
                    elevation: 10,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    itemBuilder: (BuildContext context) {
                      return [
                        const PopupMenuItem(
                          textStyle: TextStyle(color: Colors.white),
                          value: "newgroup",
                          child: Text('New Group',
                              style: TextStyle(
                                color: Colors.white,
                              )),
                        ),
                        PopupMenuItem(
                          child: const Text('New community',
                              style: TextStyle(color: Colors.black)),
                          onTap: () {
                            log('pop up button pressed');
                            AddCommunityScreen().addCommunityDialog(context);
                          },
                        ),
                        const PopupMenuItem(
                            child: Text(
                          'New Group',
                          style: TextStyle(color: Colors.black),
                        )),
                        const PopupMenuItem(
                            child: Text(
                          'New Group',
                          style: TextStyle(color: Colors.black),
                        )),
                      ];
                    })
              ],
              bottom: TabBar(
                controller: _controller,
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                tabs: const [
                  Tab(
                    text: 'Connect',
                  ),
                  Tab(
                    text: 'Chats',
                  ),
                  Tab(
                    text: 'Community',
                  ),
                  Tab(
                    text: 'Status',
                  ),
                ],
              ),
            ),
            body: TabBarView(
              controller: _controller,
              children: [
                const StoryScreen(),
                HomeScreenFinal(
                  isSearching: isSearchingHasValue,
                  value: value,
                ),
                CommunityScreenFinal(
                  isSearching: isSearchingHasValue,
                  value: value,
                ),
                const StatusScreenn(),
              ],
            ),
          ),
        ));
  }
}
