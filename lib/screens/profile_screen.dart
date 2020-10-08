import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:poster/widgets/general/poster_card.dart';

import '../data/models/poster_card_model.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  // This is dummy data for this page
  final PosterCardModel _posterCardModel1 = new PosterCardModel(
      title: 'Harmony Concert 2020',
      date: '20 Sep, 2020',
      location: 'Embong anyar Street no 10, Malang',
      description:
          'Ipsum is simply dummy of the printing and typesetting industry. Lorem Ipsum',
      posterImage: 'assets/dummy_images/poster1.png');

  @override
  void initState() {
    super.initState();
    _controller = TabController(initialIndex: 0, length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Container(
            height: 90,
            child: Stack(
              children: [
                Container(
                  height: 70,
                  decoration: BoxDecoration(
                      color: Color(0xFF40407A),
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(60))),
                ),
                Positioned(
                  bottom: 10,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        CircleAvatar(
                            radius: 35,
                            backgroundImage:
                                AssetImage('assets/dummy_images/user1.png')),
                        SizedBox(
                          width: 10,
                        ),
                        Wrap(
                          direction: Axis.vertical,
                          children: [
                            Text(
                              'John Doe',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Edit Profile',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  EvaIcons.edit2Outline,
                                  size: 15,
                                  color: Colors.white,
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TabBar(
              controller: _controller,
              unselectedLabelColor: Color(0xFFABABD3),
              unselectedLabelStyle: TextStyle(color: Color(0xFFE3E8E9)),
              indicatorColor: Color(0xFF40407A),
              labelColor: Color(0xFF40407A),
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              tabs: [
                Tab(
                  child: Text('Mine'),
                ),
                Tab(
                  child: Text('Subscription'),
                )
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _controller,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        PosterCard(
                          posterCardModel: _posterCardModel1,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        PosterCard(
                          posterCardModel: _posterCardModel1,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
