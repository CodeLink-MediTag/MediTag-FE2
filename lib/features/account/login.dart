import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: false,
        child: Center(
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Title(),
          _Input(),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Column(
        children: [
          SizedBox(height: 40),
          Text(
            '로그인',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ],
      ),
    );
  }
}

class _Input extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController(text: 'test@gmail.com');
  final TextEditingController passwordController = TextEditingController(text: 'test12345');
  String responseText = '';

  _Input({Key? key}) : super(key: key);

  Future<void> loginUser(BuildContext context) async {
    var url = Uri.parse('http://localhost:8080/api/auth/login');

    var headers = {"Content-Type": "application/json"};
    var body = jsonEncode({
      "username": usernameController.text,
      "password": passwordController.text,
    });

    try {
      var response = await http.post(url, headers: headers, body: body);
      var data = jsonDecode(response.body);
      responseText = data.toString();

      if (response.statusCode == 200) {
        String token = data['accessToken'];

        await showPopupAndWait(context, "로그인 성공");

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', token);

        Navigator.pushNamed(context, '/landing'); // ✅ 네임드 라우트 사용
      } else {
        await showPopupAndWait(context, "로그인 실패");
      }
    } catch (e) {
      await showPopupAndWait(context, "에러발생 $e");
    }
  }

  Future<void> showPopupAndWait(BuildContext context, String title) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text('서버 반환 내용:\n$responseText'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 6,
      child: Column(
        children: [
          Text('아이디', style: TextStyle(fontSize: 20)),
          SizedBox(height: 10),
          TextField(
            controller: usernameController,
            decoration: InputDecoration(
              labelText: 'ID',
              suffixIcon: Icon(Icons.person, color: Colors.grey[500]),
            ),
          ),
          SizedBox(height: 30),
          Text('비밀번호', style: TextStyle(fontSize: 20)),
          SizedBox(height: 10),
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'PASSWORD',
              suffixIcon: Icon(Icons.lock, color: Colors.grey[500]),
            ),
          ),
          SizedBox(height: 50),
          ElevatedButton(
            onPressed: () => loginUser(context),
            child: Text('로그인'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/signup'); // ✅ 네임드 라우트 사용
            },
            child: Text('회원가입'),
          ),
        ],
      ),
    );
  }
}
