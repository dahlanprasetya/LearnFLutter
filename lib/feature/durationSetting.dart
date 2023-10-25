import 'package:flutter/material.dart';

class DurationSetting extends StatefulWidget {
  @override
  _DurationSettingState createState() => new _DurationSettingState();
}

class _DurationSettingState extends State<DurationSetting> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: 'Integer'),
            ],
          ),
          title: Text('Numberpicker example'),
        ),
        body: TabBarView(
          children: [
            _IntegerExample(),
          ],
        ),
      ),
    );
  }
}

class _IntegerExample extends StatefulWidget {
  @override
  __IntegerExampleState createState() => __IntegerExampleState();
}

class __IntegerExampleState extends State<_IntegerExample> {
  int _currentValue1 = 3;
  int _currentValue2 = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // NumberPicker(
        //   value: _currentValue,
        //   minValue: 1,
        //   maxValue: 60,
        //   onChanged: (value) => setState(() => _currentValue = value),
        //   itemHeight: 15,
        //   itemWidth: 15,
        //   axis: Axis.horizontal,
        //   textStyle: TextStyle(fontSize: 0),
        //   selectedTextStyle: TextStyle(fontSize: 13, color: Colors.red),
        // ),
        SizedBox(height: 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Timeout Inactivity'),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  iconSize: 10,
                  onPressed: () => setState(() {
                    final newValue = _currentValue1 - 1;
                    _currentValue1 = newValue.clamp(1, 60);
                  }),
                ),
                Text('$_currentValue1'),
                IconButton(
                  iconSize: 10,
                  icon: Icon(Icons.add),
                  onPressed: () => setState(() {
                    final newValue = _currentValue1 + 1;
                    _currentValue1 = newValue.clamp(1, 60);
                  }),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Timeout Lost Focus'),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  iconSize: 10,
                  onPressed: () => setState(() {
                    final newValue = _currentValue2 - 1;
                    _currentValue2 = newValue.clamp(1, 60);
                  }),
                ),
                Text('$_currentValue2'),
                IconButton(
                  iconSize: 10,
                  icon: Icon(Icons.add),
                  onPressed: () => setState(() {
                    final newValue = _currentValue2 + 1;
                    _currentValue2 = newValue.clamp(1, 60);
                  }),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
