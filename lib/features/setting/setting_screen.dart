import 'package:flutter/material.dart';
import 'package:untitled9/components/custom_app_bar.dart';
import 'package:untitled9/features/alert_sound/alert_sound.dart';
import 'package:untitled9/features/card_registration/card_registration.dart';
import 'package:untitled9/routes/route_names.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool notifications = true;
  bool sound = true;
  bool vibration = true;
  bool showNotifications = false;
  double textSize = 14.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: Column(
        children: [
          // ✅ 커스텀 앱바 적용
          CustomAppBar(title: '환경설정'),

          // ✅ 설정 내용
          Expanded(
            child: Container(
              color: const Color(0xFFF6F6F6),
              child: ListView(
                children: [
                  _buildSettingTile('알림', Switch(
                    value: notifications,
                    onChanged: (value) {
                      setState(() => notifications = value);
                    },
                    activeColor: Colors.blue,
                  )),
                  _buildDivider(),

                  _buildSettingTile('소리', Switch(
                    value: sound,
                    onChanged: (value) {
                      setState(() => sound = value);
                    },
                    activeColor: Colors.blue,
                  )),
                  _buildDivider(),

                  _buildNavigationButton('알림음', () {
                    Navigator.pushNamed(context, RouteName.alertSound);
                  }),
                  _buildDivider(),

                  _buildSettingTile('진동', Switch(
                    value: vibration,
                    onChanged: (value) {
                      setState(() => vibration = value);
                    },
                    activeColor: Colors.blue,
                  )),
                  _buildDivider(),

                  // ✅ 글자 크기 슬라이더
                  Container(
                    padding: const EdgeInsets.all(16),
                    color: const Color(0xFFFDFDFD),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '글자 크기',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                        Slider(
                          value: textSize,
                          min: 10,
                          max: 24,
                          divisions: 7,
                          label: textSize.toString(),
                          onChanged: (value) {
                            setState(() => textSize = value);
                          },
                        ),
                      ],
                    ),
                  ),
                  _buildDivider(),

                  _buildSettingTile('알림 표시', Switch(
                    value: showNotifications,
                    onChanged: (value) {
                      setState(() => showNotifications = value);
                    },
                    activeColor: Colors.blue,
                  )),
                  _buildDivider(),

                  _buildNavigationButton('NFC 등록', () {
                    Navigator.pushNamed(context, RouteName.cardRegistration);
                  }),
                  _buildDivider(),

                  const SizedBox(height: 20),

                  // ✅ 로그아웃 버튼
                  Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF547EE8),
                        minimumSize: const Size(358, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        '로그아웃',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingTile(String title, Widget trailing) {
    return Container(
      color: const Color(0xFFFDFDFD),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ),
        trailing: trailing,
      ),
    );
  }

  Widget _buildNavigationButton(String title, VoidCallback onPressed) {
    return Container(
      color: const Color(0xFFFDFDFD),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 20, color: Colors.black),
        onTap: onPressed,
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 2,
      color: const Color(0xFFDADADA),
    );
  }
}
