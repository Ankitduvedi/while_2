import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as river;
import 'package:provider/provider.dart';
import 'package:while_app/resources/colors.dart';
import 'package:while_app/resources/components/create_container.dart';
import 'package:while_app/view_model/post_provider.dart';
import 'package:while_app/view_model/reel_controller.dart';

class CreateScreen extends river.ConsumerStatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  river.ConsumerState<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends river.ConsumerState<CreateScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ReelController>(context, listen: false);
    final postProvider = Provider.of<PostProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            const Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text("Upload",
                    style: TextStyle(
                        color: AppColors.buttonColor,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Sen",
                        fontSize: 25)),
              ],
            ),
            const SizedBox(height: 8),
            const SizedBox(
              height: 30,
            ),
            CreateContainer(
                text: "Videos",
                function: () {
                  provider.selectVideo(context);
                }),
            CreateContainer(
                text: "Reels",
                function: () {
                  provider.selectVideo(context);
                }),
          ],
        ),
      ),
    );
  }
}
