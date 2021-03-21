import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:poster/cubit/user_cubit.dart';

import '../cubit/subscriber_cubit.dart';
import '../data/models/poster_card_model.dart';
import '../data/subscriber_repository.dart';
import '../modules/date_formater.dart';
import '../widgets/general/bottom_button.dart';

class DetailItemScreen extends StatefulWidget {
  @override
  _DetailItemScreenState createState() => _DetailItemScreenState();
}

class _DetailItemScreenState extends State<DetailItemScreen> {
  PosterCardModel _dataDetail;
  SubscriberCubit _subscriberCubit;
  String userId;

  @override
  void initState() {
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    userId = BlocProvider.of<UserCubit>(context).user.id;
    _subscriberCubit = SubscriberCubit(ImpSubscriberRepository());

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _dataDetail = ModalRoute.of(context).settings.arguments;
      });

      String posterId = _dataDetail.id;

      _subscriberCubit.checkSubscriberStatus(userId, posterId);
    });
  }

  // Navigate to poster image detail
  _toPosterImage(BuildContext context, String image) {
    Navigator.pushNamed(context, '/detail_poster_image', arguments: image);
  }

  // Set event's start and end date
  String _setDate(String startDate, String endDate) {
    String startDateFormat =
        DateFormater.standardDate(DateTime.parse(startDate));
    String endDateFormat = DateFormater.standardDate(DateTime.parse(endDate));

    if (startDate != endDate) {
      return '$startDateFormat to $endDateFormat';
    }

    return startDateFormat;
  }

  // Set info
  Widget _setInfo(Icon icon, String info) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          icon,
          SizedBox(
            width: 10,
          ),
          Flexible(
              child: Text(
            info,
          ))
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
      bottomSheet: BlocProvider(
        create: (context) => _subscriberCubit,
        child: Builder(
          builder: (context) {
            return BlocBuilder<SubscriberCubit, SubscriberState>(
              cubit: _subscriberCubit,
              builder: (context, state) {
                if (state is SubscriberLoading) {
                  return BottomButton(
                    title: 'Loading...',
                    color: Colors.grey,
                  );
                } else if (state is SubscriberLoaded) {
                  if (!state.isSubscribed) {
                    return BottomButton(
                      title: 'SUBSCRIBE',
                    );
                  }
                  return BottomButton(
                    title: 'UNSUBSCRIBE',
                    color: Colors.grey,
                  );
                }

                return BottomButton(
                  title: 'Loading...',
                  color: Colors.grey,
                );
              },
            );
          },
        ),
      ),
      body: _dataDetail == null
          ? Container()
          : SingleChildScrollView(
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
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
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
                                image: NetworkImage(_dataDetail.posterImage),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 100,
                          top: 70,
                          child: GestureDetector(
                            onTap: () => _toPosterImage(
                                context, _dataDetail.posterImage),
                            child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  EvaIcons.expandOutline,
                                  color: Colors.grey,
                                )),
                          ),
                        ),
                        Positioned(
                            top: 60,
                            left: 150,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              width: 195,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _dataDetail.title,
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  _setInfo(
                                    Icon(EvaIcons.calendarOutline),
                                    _setDate(_dataDetail.startDate,
                                        _dataDetail.endDate),
                                  ),
                                  _setInfo(Icon(EvaIcons.pinOutline),
                                      _dataDetail.location),
                                  _setInfo(Icon(EvaIcons.creditCardOutline),
                                      _dataDetail.price),
                                  _setInfo(Icon(EvaIcons.twitterOutline),
                                      _dataDetail.twitter),
                                  _setInfo(Icon(EvaIcons.cameraOutline),
                                      _dataDetail.instagram),
                                  _setInfo(Icon(EvaIcons.facebookOutline),
                                      _dataDetail.facebook),
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    child: Text(
                      'Description',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Text(_dataDetail.description),
                  ),
                  SizedBox(
                    height: 90,
                  )
                ],
              ),
            ),
    );
  }
}
