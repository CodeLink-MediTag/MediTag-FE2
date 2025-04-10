import 'package:flutter/material.dart';
import 'package:untitled9/features/medication/renew.dart';
import 'package:untitled9/features/calendar/calendar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../screens/landing_page.dart';

class Eatmed1 extends StatefulWidget {
  const Eatmed1({Key? key}) : super(key: key);

  @override
  State<Eatmed1> createState() => _Eatmed1State();
}

class Medicine {
  final String medicineName;
  final String characteristic;
  final String? imageUrl;
  final bool prescribed;
  final List<Alarm> alarms;

  Medicine({
    required this.medicineName,
    required this.characteristic,
    this.imageUrl,
    required this.prescribed,
    required this.alarms,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      medicineName: json['medicineName'],
      characteristic: json['characteristic'],
      imageUrl: json['imageUrl'],
      prescribed: json['prescribed'],
      alarms: (json['alarms'] as List)
          .map((alarm) => Alarm.fromJson(alarm))
          .toList(),
    );
  }
}

class Alarm {
  final DateTime alarmTime;
  bool taking;

  Alarm({required this.alarmTime, required this.taking});

  factory Alarm.fromJson(Map<String, dynamic> json) {
    return Alarm(
      alarmTime: DateTime.parse(json['alarmTime']),
      taking: json['taking'],
    );
  }
}

class _Eatmed1State extends State<Eatmed1> {
  List<Medicine> medicines = [];
  bool isLoading = true;
  String currentDate = '';
  String? token;

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
    });
    fetchMedicines();
  }

  Future<void> fetchMedicines() async {
    if (token == null) {
      print('토큰이 없습니다. 로그인이 필요합니다.');
      setState(() => isLoading = false);
      return;
    }

    setState(() => isLoading = true);
    try {
      String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
      currentDate = today;

      final response = await http.get(
        Uri.parse('http://localhost:8080/api/medicines?date=$today'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        List<Medicine> fetchedMedicines = (data['medicines'] as List)
            .map((medicine) => Medicine.fromJson(medicine))
            .toList();

        setState(() {
          medicines = fetchedMedicines;
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
        print('Failed to load medicines: ${response.statusCode}');
      }
    } catch (e) {
      setState(() => isLoading = false);
      print('Error fetching medicines: $e');
    }
  }

  Future<void> updateMedicineTaking(Medicine medicine, Alarm alarm) async {
    if (token == null) {
      print('토큰이 없습니다. 로그인이 필요합니다.');
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://localhost:8080/api/medicines/taking'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'medicineName': medicine.medicineName,
          'alarmTime': alarm.alarmTime.toIso8601String(),
          'taking': alarm.taking,
        }),
      );

      if (response.statusCode == 200) {
        print('약 복용 상태가 업데이트되었습니다.');
      } else {
        print('업데이트 실패: ${response.statusCode}');
      }
    } catch (e) {
      print('업데이트 중 오류 발생: $e');
    }
  }

  void toggleTaking(Medicine medicine, Alarm alarm) {
    setState(() => alarm.taking = !alarm.taking);
    updateMedicineTaking(medicine, alarm);
  }

  void showMedicationDialog(Medicine medicine, Alarm alarm) {
    String formattedTime =
    DateFormat('a hh:mm', 'ko_KR').format(alarm.alarmTime);

    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          width: 330,
          height: 210,
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(medicine.medicineName,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text("$formattedTime에 약을 드셨나요?",
                  style: TextStyle(fontSize: 19, color: Colors.grey)),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF547EE8),
                      fixedSize: Size(128, 54),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: () {
                      toggleTaking(medicine, alarm);
                      Navigator.pop(context);
                    },
                    child: Text("네",
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey.shade300,
                      fixedSize: Size(128, 54),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Text("아니요",
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTimeButton(Medicine medicine, Alarm alarm) {
    String formattedTime =
    DateFormat('a hh:mm', 'ko_KR').format(alarm.alarmTime);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
          alarm.taking ? Color(0xFFA3BCF1) : Colors.white,
          minimumSize: Size(110, 55),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)),
        ),
        onPressed: () {
          if (alarm.taking) {
            toggleTaking(medicine, alarm);
          } else {
            showMedicationDialog(medicine, alarm);
          }
        },
        child: Text(
          alarm.taking ? '복용 완료!' : formattedTime,
          style: TextStyle(
              fontSize: 14,
              color: alarm.taking ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  Widget buildMedicationCard(Medicine medicine) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(medicine.medicineName,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text(medicine.characteristic, style: TextStyle(fontSize: 16)),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: medicine.alarms
                .map((alarm) => buildTimeButton(medicine, alarm))
                .toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 상단 바
          Container(
            color: Color(0xFF547EE8),
            padding: EdgeInsets.only(top: 37, bottom: 12, left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pushNamed(context, '/home'),
                ),
                Text('메인 화면',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.white)),
                IconButton(
                  icon: Icon(Icons.calendar_today, color: Colors.white),
                  onPressed: () => Navigator.pushNamed(context, '/calendar'),
                ),
              ],
            ),
          ),

          // 본문
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : medicines.isEmpty
                ? Center(
                child: Text('등록된 약이 없습니다.',
                    style: TextStyle(fontSize: 18)))
                : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  ...medicines
                      .map((medicine) => Column(
                    children: [
                      buildMedicationCard(medicine),
                      SizedBox(height: 40),
                    ],
                  ))
                      .toList(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF547EE8),
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: () =>
                        Navigator.pushNamed(context, '/renew'),
                    child: Text('알림 받을 약 추가',
                        style: TextStyle(
                            fontSize: 18, color: Colors.white)),
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
