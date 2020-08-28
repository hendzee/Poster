import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class DetailItemScreen extends StatefulWidget {
  @override
  _DetailItemScreenState createState() => _DetailItemScreenState();
}

class _DetailItemScreenState extends State<DetailItemScreen> {
  // Set info
  Widget _setInfo(Icon icon, String info) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          icon,
          SizedBox(width: 10,),
          Text(info)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Item'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 410,
              child: Stack(
                children: [
                  Positioned(
                    left: 30,
                    top: 30,
                    child: Container(
                      width: 200,
                      height: 350,
                      decoration: BoxDecoration(
                        color: Color(0xFFF0EBF4),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                    ),
                  ),
                  Positioned(
                    left: -60,
                    top: 50,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Container(
                        width: 200,
                        height: 350,
                        child: Image(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/dummy_images/poster-large1.png'),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 100,
                    top: 70,
                    child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.white,
                        child: Icon(EvaIcons.expandOutline, color: Colors.grey,)
                    ),
                  ),
                  Positioned(
                    top: 60,
                    left: 150,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      width: 195,
                      child: Column(
                        children: [
                          Text('Music Zombie Party', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                          SizedBox(height: 10,),
                          this._setInfo(Icon(EvaIcons.calendarOutline), '20 Sep, 2020'),
                          this._setInfo(Icon(EvaIcons.pinOutline), 'Matos, Malang'),
                          this._setInfo(Icon(EvaIcons.creditCardOutline), 'Free'),
                          this._setInfo(Icon(EvaIcons.twitterOutline), 'MZP2020'),
                          this._setInfo(Icon(EvaIcons.cameraOutline), 'MZP2020'),
                          this._setInfo(Icon(EvaIcons.facebookOutline), 'MZP2020'),
                        ],
                      ),
                    )
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(25),
              child: Text('Ipsum is simply dummy  of the printing and industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s,  when an unknown printer.'),
            ),
            SizedBox(height: 50,)
          ],
        )
      )
    );
  }
}
