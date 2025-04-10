import 'package:flutter/material.dart';

class AlertSound extends StatefulWidget {
  const AlertSound({super.key});

  @override
  _AlertSoundPageState createState() => _AlertSoundPageState();
}

class _AlertSoundPageState extends State<AlertSound> {
  String selectedSound = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6), // 연한 회색 배경
      body: Column(
        children: [
          Container(
            color: Color(0xFF547EE8),
            padding: const EdgeInsets.only(top: 37, bottom: 12),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 0,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                const Center(
                  child: Text(
                    '알림음',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          _buildSoundTile('알림음1'),
          _buildDivider(),
          _buildSoundTile('알림음2'),
          _buildDivider(),
          _buildSoundTile('알림음3'),
        ],
      ),
    );
  }

  Widget _buildSoundTile(String soundName) {
    return Container(
      color: Colors.white,
      child: ListTile(
        title: Text(
          soundName,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ),
        trailing: Checkbox(
          value: selectedSound == soundName,
          onChanged: (value) {
            setState(() => selectedSound = value! ? soundName : "");
          },
          activeColor: const Color(0xFF61B781),
        ),
        onTap: () {
          setState(() => selectedSound = soundName);
        },
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 2,
      color: const Color(0xFFDADADA),
      width: double.infinity,
    );
  }
}
