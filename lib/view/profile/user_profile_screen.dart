import 'package:flutter/material.dart';
import 'package:while_app/view/profile/creator_profile_widget.dart';
import 'package:while_app/view/profile/profile_data_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const tabBarIcons = [
      Tab(
        icon: Icon(
          Icons.photo_outlined,
          color: Colors.white,
          size: 30,
        ),
      ),
      Tab(
        icon: Icon(
          Icons.person,
          color: Colors.white,
          size: 30,
        ),
      ),
      Tab(
        icon: Icon(
          Icons.brush,
          color: Colors.white,
          size: 30,
        ),
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: DefaultTabController(
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
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Material(
                  color: Colors.black,
                  child: TabBar(
                    padding: EdgeInsets.all(0),
                    indicatorColor: Colors.white,
                    tabs: tabBarIcons,
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      Center(child: CreatorProfile()),
                      const Center(
                          child: Text(
                        "Become a Mentor",
                        style: TextStyle(color: Colors.white),
                      )),
                      const Center(
                          child: Text(
                        "Become a Freelancer",
                        style: TextStyle(color: Colors.white),
                      )),
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
