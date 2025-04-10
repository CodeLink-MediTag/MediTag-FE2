import 'package:flutter/material.dart';
import 'package:untitled9/screens/landing_page.dart';
import 'package:untitled9/features/account/account.dart';
import 'package:untitled9/features/account/login.dart';
import 'package:untitled9/features/chatbot/chatbot.dart';
import 'package:untitled9/features/calendar/calendar.dart';
import 'package:untitled9/features/medication/eatmedi1.dart';
import 'package:untitled9/features/medication/MedicationDetail.dart';
import 'package:untitled9/features/medication/MedicationEdit.dart';
import 'package:untitled9/features/medication/renew.dart';
import 'package:untitled9/features/medication/renewday.dart';
import 'package:untitled9/features/medication/renewpo.dart';
import 'package:untitled9/features/recording/recording.dart';
import 'package:untitled9/features/alert_sound/alert_sound.dart';
import 'package:untitled9/features/card_registration/card_registration.dart';
import 'package:untitled9/features/setting/setting_screen.dart';
import 'route_names.dart';
import 'package:untitled9/features/medication/renewday.dart';


class AppRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.landing:
        return MaterialPageRoute(builder: (_) => const LandingPage());
      case RouteName.login:
        return MaterialPageRoute(builder: (_) => const Login());
      case RouteName.account:
        return MaterialPageRoute(builder: (_) => SignupScreen());
      case RouteName.chatbot:
        return MaterialPageRoute(builder: (_) => ChatBotScreen());
      case RouteName.calendar:
        return MaterialPageRoute(builder: (_) => CalendarScreen());
      case RouteName.eatMedi:
        return MaterialPageRoute(builder: (_) =>  Eatmed1());
      case RouteName.medicationDetail:
        return MaterialPageRoute(builder: (_) =>  MedicationDetail());
      case RouteName.medicationEdit:
        return MaterialPageRoute(builder: (_) =>  MedicationDetail());
      case RouteName.renew:
        return MaterialPageRoute(builder: (_) =>  RenewScreen());
      case RouteName.renewDay:
        return MaterialPageRoute(builder: (_) => const RenewpoScreen());
      case RouteName.renewPo:
        return MaterialPageRoute(builder: (_) => const RenewpoScreen());
      case RouteName.recording:
        return MaterialPageRoute(builder: (_) => const RecordingScreen());
      case RouteName.alertSound:
        return MaterialPageRoute(builder: (_) => AlertSound());
      case RouteName.cardRegistration:
        return MaterialPageRoute(builder: (_) => const CardRegistration());
      case RouteName.settings:
        return MaterialPageRoute(builder: (_) => SettingScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('잘못된 경로: ${settings.name}')),
          ),
        );
    }
  }
}
