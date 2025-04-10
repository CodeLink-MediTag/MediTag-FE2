import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardRegistration extends StatelessWidget {
  const CardRegistration({super.key});

  static const String routeName = '/card_registration';

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF547EE8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            minimumSize: Size(500, 80),
            textStyle: TextStyle(fontSize: 30),
            foregroundColor: Colors.white,
          ),
        ),
      ),
      child: Scaffold(
        body: Center(
          child: HomeScreen(),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _TopBar(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _MainView(),
          ),
        ),
      ],
    );
  }
}

class _TopBar extends StatelessWidget {
  _TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 37, bottom: 12),
      color: Color(0xFF547EE8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Container(
            width: 200,
            child: Center(
              child: Text(
                '시간카드 등록',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
          ),
        ],
      ),
    );
  }
}

class _MainView extends StatelessWidget {
  _MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _Select(),
          _Notice(),
        ],
      ),
    );
  }
}

class _Select extends StatelessWidget {
  _Select({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: Text('아침'),
            ),
            SizedBox(height: 60),
            ElevatedButton(
              onPressed: () {},
              child: Text('점심'),
            ),
            SizedBox(height: 60),
            ElevatedButton(
              onPressed: () {},
              child: Text('저녁'),
            ),
          ],
        ),
      ),
    );
  }
}

class _Notice extends StatelessWidget {
  _Notice({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        '시간을 선택하고 카드를 태그해주세요',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}