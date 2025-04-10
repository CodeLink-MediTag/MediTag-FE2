import 'package:flutter/material.dart';
import 'package:untitled9/components/custom_app_bar.dart';
import 'package:untitled9/components/home_button.dart';
import 'package:untitled9/features/chatbot/chatbot.dart';
import 'package:untitled9/features/medication/eatmedi1.dart';
import 'package:untitled9/features/recording/recording.dart';
// import 'package:untitled9/screen/camera.dart'; // 카메라 인식 화면 추가 예정

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(title: '메인 화면'), // ✅ 수정된 부분
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF547EE8),
                      fixedSize: const Size(340, 322),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChatBotScreen()),
                      );
                    },
                    child: const Text(
                      '챗봇',
                      style: TextStyle(
                        fontSize: 62,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  HomeButton(
                    text: '복용 알림/여부',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Eatmed1()),
                      );
                    },
                  ),
                  HomeButton(
                    text: '주의사항 녹음',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RecordingScreen()),
                      );
                    },
                  ),
                  HomeButton(
                    text: '카메라 인식',
                    onPressed: () {
                      // TODO: 카메라 인식 연결
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
