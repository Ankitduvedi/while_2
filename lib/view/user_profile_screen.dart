import 'package:flutter/material.dart';
import 'package:while_app/resources/components/profile_data_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const tabBarIcons = [
      Tab(
        icon: Icon(
          Icons.photo_outlined,
          color: Colors.black,
          size: 30,
        ),
      ),
      Tab(
        icon: Icon(
          Icons.person,
          color: Colors.black,
          size: 30,
        ),
      ),
      Tab(
        icon: Icon(
          Icons.brush,
          color: Colors.black,
          size: 30,
        ),
      ),
    ];

    return SafeArea(
      child: Scaffold(
        body: DefaultTabController(
          length: 3,
          child: NestedScrollView(
            headerSliverBuilder: (context, _) {
              return [
                SliverList(
                  delegate: SliverChildListDelegate(
                    const [ProfileDataWidget()],
                  ),
                ),
              ];
            },
            body: const Column(
              children: [
                Material(
                  child: TabBar(
                    padding: EdgeInsets.all(0),
                    indicatorColor: Colors.black,
                    tabs: tabBarIcons,
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      Center(child: Text("Become a Content creator")),
                      Center(child: Text("Become a Mentor")),
                      Center(child: Text("Become a Freelancer")),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
