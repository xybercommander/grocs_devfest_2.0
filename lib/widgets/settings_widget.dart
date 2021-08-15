// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class SettingsTile extends StatefulWidget {
  final IconData icon;
  final Color color;
  final String title;  
  const SettingsTile({ 
    Key key, 
    @required this.color, 
    @required this.title, 
    @required this.icon 
  }) : super(key: key);

  @override
  _SettingsTileState createState() => _SettingsTileState();
}

class _SettingsTileState extends State<SettingsTile> {

  bool darkMode = false;

  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: widget.color.withOpacity(0.6),
            borderRadius: BorderRadius.circular(50)
          ),
          child: Center(
            child: Icon(widget.icon, color: widget.color,),
          ),
        ),
        SizedBox(width: 12,),
        Text(widget.title, style: TextStyle(fontSize: 18),),
        Spacer(),
        Container(
          child: widget.title == 'Dark Mode'
            ? FlutterSwitch(
                value: darkMode,
                showOnOff: true,
                onToggle: (value) {
                  setState(() {
                    darkMode = value;
                  });
                },
              )
            : Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Center(
                  child: Icon(Icons.keyboard_arrow_right)
                ),
              ),
        )
      ],
    );    
  }
}