import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:while_app/resources/components/classroom/class_timetable.dart';
import 'package:while_app/resources/components/classroom/profile_screen_class_admin.dart';
import 'package:while_app/resources/components/communities/community_detail_resources_widget%20.dart';
import 'package:while_app/resources/components/message/apis.dart';
import 'package:while_app/resources/components/message/models/classroom_user.dart';

late Size mq;

class ClassDetailScreen extends StatefulWidget {
  const ClassDetailScreen({Key? key, required this.clas}) : super(key: key);
  final Class clas;
  @override
  State<ClassDetailScreen> createState() => ClassDetailScreenState();
}

class ClassDetailScreenState extends State<ClassDetailScreen> {
  /// List of Tab Bar Item

  List<String> itemsName = const [
    'Chat',
    'Resources',
    'Opportunites',
    'Quiz',
  ];
  int current = 0;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    log('height ${mq.height}');
    var keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    log(keyboardSpace.toString());
    List items = [
      //  CChatScreen(
      //   user: widget.user,
      // ),
      const CommunityDetailResources(),
      //OpportunitiesScreen(user: ),
      TimeTable(),
    ];
    return Scaffold(
      backgroundColor: Colors.white,

      /// APPBAR
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: GestureDetector(
          onTap: () {
            if (widget.clas.email == APIs.me.email) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ProfileScreenClass(user: widget.clas)));
            } else {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (_) =>
              //             ProfileScreenParticipant(user: widget.user)));
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 15,
              ),
              Text(widget.clas.name),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          /// CUSTOM TABBAR
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: items.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, index) {
                  return Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            current = index;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.only(top: 10, left: 12),
                          width: itemsName[index].length.toDouble() * 4 + 60,
                          height: 45,
                          decoration: BoxDecoration(
                            color: current == index
                                ? Colors.white70
                                : Colors.white54,
                            borderRadius: current == index
                                ? BorderRadius.circular(15)
                                : BorderRadius.circular(10),
                            border: current == index
                                ? Border.all(
                                    color: Colors.deepPurpleAccent, width: 2)
                                : null,
                          ),
                          child: Center(
                            child: Text(
                              itemsName[index],
                              // style: GoogleFonts.laila(
                              //     fontWeight: FontWeight.w500,
                              //     color: current == index
                              //         ? Colors.black
                              //         : Colors.grey),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                          visible: current == index,
                          child: Container(
                            width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                                color: Colors.deepPurpleAccent,
                                shape: BoxShape.circle),
                          ))
                    ],
                  );
                }),
          ),

          /// MAIN BODY

          SingleChildScrollView(
            child: SizedBox(
              height: mq.height - keyboardSpace - mq.height / 5.2,
              child: items[current],
            ),
          ),
        ],
      ),
    );
  }
}
