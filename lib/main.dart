import 'package:firebase_core/firebase_core.dart';
import 'package:liquid_bash/pages/add_tournament.dart';
import 'package:liquid_bash/pages/admin_dashboard.dart';
import 'package:liquid_bash/pages/home_logged.dart';
import 'package:liquid_bash/pages/home_loggedt.dart';
import 'package:liquid_bash/pages/registration_first.dart';
import 'package:liquid_bash/pages/response.dart';
import 'package:liquid_bash/pages/view_users.dart';
import 'package:provider/provider.dart';
import 'package:liquid_bash/pages/category_selection.dart';
import 'package:liquid_bash/pages/home.dart';
import 'package:liquid_bash/pages/event.dart';
import 'package:liquid_bash/services/news_service.dart';
import 'package:liquid_bash/services/tournament_service.dart';
import 'pages/registration.dart';
import 'pages/signup.dart';
import 'pages/login.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TournamentService()),
        ChangeNotifierProvider(create: (_) => NewsService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final int _duration = 0;
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final mainGreenColor = Color.fromARGB(255, 0, 255, 136);

    TournamentService torService =
        Provider.of<TournamentService>(context, listen: false);
    NewsService newsService = Provider.of<NewsService>(context, listen: false);
    Future.delayed(Duration(seconds: _duration), () async {
      newsService.fetchNews().then((value) {});
    });

    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/event': (context) => const EventPage(),
        '/register': (context) => const RegistrationPage(),
        '/signup': (context) => const SignUp(),
        '/login': (context) => const LoginPage(),
        '/view-users': (context) => const ViewUsers(),
        '/profile-settings': (context) => Container(),
        '/add-tournment': (context) => const AddTournment(),
        '/registration-first': (context) => const RegistrationFirst(),
        '/response': (context) => const Response(),
        '/categories-selection': (context) => const CategorySelectionPage(),
        '/': (context) => const HomePage(),
        '/homelogged': (context) => const HomeLogged(),
        '/homeloggedt': (context) => const HomeLoggedT(),
        '/admin': (context) => Adminhome(),
      },
      title: 'Liquid Bash',
      theme: ThemeData(
          // brightness: Brightness.dark,
          primaryColor: Colors.white,
          primaryColorLight: Colors.grey.shade700,
          primaryColorDark: Colors.grey.shade900,
          accentColor: mainGreenColor,
          focusColor: mainGreenColor,
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  primary: mainGreenColor,
                  onPrimary: Colors.black,
                  textStyle: TextStyle(color: Colors.black))),
          buttonTheme:
              ButtonThemeData(buttonColor: Theme.of(context).accentColor),
          iconTheme: const IconThemeData(color: Colors.white),
          primaryIconTheme: const IconThemeData(color: Colors.white),
          appBarTheme: AppBarTheme(
              centerTitle: true,
              color: Colors.grey.shade900,
              titleTextStyle: const TextStyle(
                color: Colors.white,
              )),
          colorScheme: ColorScheme.fromSwatch(
                  primarySwatch: MaterialColor(0xff00FFA8, const {}),
                  brightness: Brightness.dark)
              .copyWith(secondary: Colors.greenAccent.shade700)),
    );
  }
}