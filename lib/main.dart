import 'package:flutter/material.dart';
import 'package:poster/cubit/user_cubit.dart';
import 'package:poster/screens/add_item_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './screens/add_item_screen.dart';
import './screens/detail_item_screen.dart';
import './screens/login_screen.dart';
import './screens/main_screen.dart';
import './screens/splash_screen.dart';
import './screens/register_profile_screen.dart';
import './screens/register_password_screen.dart';
import './screens/profile_menu_screen.dart';
import './screens/edit_profile_screen.dart';
import './screens/change_password_screen.dart';
import './screens/detail_image_poster_screen.dart';
import './data/user_repository.dart';

void main() {
  runApp(Poster());
}

class Poster extends StatelessWidget {
  UserCubit _userCubit = UserCubit(ImpUserRepository());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _userCubit,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          scaffoldBackgroundColor: const Color(0xFFFFFFFF),
          primaryColor: Color(0xFF40407A),
          accentColor: Color(0xFF40407A),
          appBarTheme: AppBarTheme(
            color: Colors.white,
            textTheme: TextTheme(headline6: TextStyle(color: Colors.black)),
            iconTheme: IconThemeData(color: Colors.black),
            elevation: 0.5,
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          '/main': (context) => MainScreen(),
          '/add_item': (context) => AddItemScreen(),
          '/detail_item': (context) => DetailItemScreen(),
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegisterProfileScreen(),
          '/register_password': (context) => RegisterPasswordScreen(),
          '/profile_menu': (context) => ProfileMenuScreen(),
          '/edit_profile': (context) => EditProfileScreen(),
          '/change_password': (context) => ChangePasswordScreen(),
          '/detail_poster_image': (context) => DetailImagePosterScreen()
        },
      ),
    );
  }
}
