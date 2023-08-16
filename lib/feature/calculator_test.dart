import 'package:flutter/material.dart';

class CalculatorTest extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<CalculatorTest> {
  String _output = "0";
  String _expression = "";

  void _onDigitPress(String digit) {
    setState(() {
      if (_output == "0") {
        _output = digit;
      } else {
        _output += digit;
      }
      _expression += digit;
    });
  }

  void _onOperatorPress(String operator) {
    setState(() {
      if (_expression.isNotEmpty) {
        _expression += " $operator ";
        _output = "0";
      }
    });
  }

  void _onEqualsPress() {
    setState(() {
      try {
        // Using RegExp to split the expression into operands and operator
        final regExp = RegExp(r'(\d+\.?\d*)\s*([\+\-\*/])\s*(\d+\.?\d*)');
        final match = regExp.firstMatch(_expression);

        if (match != null) {
          final num1 = double.parse(match.group(1)!);
          final operator = match.group(2)!;
          final num2 = double.parse(match.group(3)!);

          double result;
          switch (operator) {
            case '+':
              result = num1 + num2;
              break;
            case '-':
              result = num1 - num2;
              break;
            case '*':
              result = num1 * num2;
              break;
            case '/':
              result = num1 / num2;
              break;
            default:
              throw Exception('Invalid operator');
          }

          _expression = result.toString();
          _output = result.toString();
        }
      } catch (e) {
        _output = 'Error';
        _expression = '';
      }
    });
  }

  void _onClearPress() {
    setState(() {
      _output = "0";
      _expression = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculator')),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.all(20),
            child: Text(
              _expression,
              style: TextStyle(fontSize: 24, color: Colors.grey),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.all(20),
            child: Text(
              _output,
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton("7"),
              _buildButton("8"),
              _buildButton("9"),
              _buildOperatorButton("/"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton("4"),
              _buildButton("5"),
              _buildButton("6"),
              _buildOperatorButton("*"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton("1"),
              _buildButton("2"),
              _buildButton("3"),
              _buildOperatorButton("-"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton("0"),
              _buildButton("."),
              _buildEqualsButton(),
              _buildOperatorButton("+"),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildClearButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text) {
    return Container(
      margin: EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: () => _onDigitPress(text),
        child: Text(
          text,
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  Widget _buildOperatorButton(String text) {
    return Container(
      margin: EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: () => _onOperatorPress(text),
        child: Text(
          text,
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  Widget _buildEqualsButton() {
    return Container(
      margin: EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: _onEqualsPress,
        child: Text(
          "=",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  Widget _buildClearButton() {
    return Container(
      margin: EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: _onClearPress,
        child: Text(
          "C",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
