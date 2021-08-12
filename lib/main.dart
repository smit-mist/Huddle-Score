import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huddle_and_score/blocs/forgot_password/forgot_password_bloc.dart';
import 'package:huddle_and_score/blocs/home_nav_bar/home_nav_bar_bloc.dart';
import 'package:huddle_and_score/blocs/login/login_bloc.dart';
import 'package:huddle_and_score/blocs/signup/signup_bloc.dart';
import 'package:huddle_and_score/repositories/auth_repository.dart';
import 'package:huddle_and_score/repositories/home_repository.dart';
import 'package:huddle_and_score/routes.dart';
import 'package:huddle_and_score/screens/home_navbar_screen.dart';
import 'package:huddle_and_score/screens/auth_and_user/welcome_screen.dart';

import 'blocs/auth/auth_bloc.dart';
import 'constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthRepository _authRepository = AuthRepository();
  @override
  Widget build(BuildContext context) {
    HomeRepository().fetchFifas();
   // HomeRepository().fetchTours();
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            authRepository: _authRepository,
          )..add(
              AppStartedEvent(),
            ),
        ),
        BlocProvider<HomeNavBarBloc>(
          create: (context) => HomeNavBarBloc(),
        ),
        BlocProvider<ForgotPasswordBloc>(
          create: (context) => ForgotPasswordBloc(
            authRepository: _authRepository,
          ),
        ),
        BlocProvider<SignupBloc>(
          create: (context) => SignupBloc(
            authRepository: _authRepository,
          ),
        ),
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(
            authRepository: _authRepository,
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: kThemeColor,
        ),
        routes: routeGenerator,
        home: App(),
      ),
    );
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthInitial) {
          return WelcomeScreen();
        } else if (state is Authenticated) {
          return HomeNavBar();
        } else if (state is UnAuthenticated) {
          return WelcomeScreen();
        }
        return Container();
      },
    );
  }
}
