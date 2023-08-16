import 'package:flutter/material.dart';
import '../constants.dart' show CALCULATOR;

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  void _handleButtonPress(String buttonText) {
    if (buttonText == "C") {
      _clear();
    } else if (buttonText == "=") {
      _calculate();
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "*" ||
        buttonText == "/") {
      _setOperand(buttonText);
    } else {
      _appendToCurrentNumber(buttonText);
    }
  }

  void _clear() {
    setState(() {
      CALCULATOR.OUTPUT = "0";
      CALCULATOR.CURRENT_NUMBER = "";
      CALCULATOR.NUM_1 = 0;
      CALCULATOR.NUM_2 = 0;
      CALCULATOR.OPERAND = "";
    });
  }

  void _calculate() {
    setState(() {
      try {
        final regExp = RegExp(r'(\d+\.?\d*)\s*([\+\-\*/])\s*(\d+\.?\d*)');
        final match = regExp.firstMatch(CALCULATOR.CURRENT_NUMBER);

        if (match != null) {
          final num1 = double.parse(match.group(1)!);
          final num2 = double.parse(match.group(3)!);

          switch (CALCULATOR.OPERAND) {
            case "+":
              CALCULATOR.OUTPUT = (num1 + num2).toString();
              break;
            case "-":
              CALCULATOR.OUTPUT = (num1 - num2).toString();
              break;
            case "*":
              CALCULATOR.OUTPUT = (num1 * num2).toString();
              break;
            case "/":
              CALCULATOR.OUTPUT = (num1 / num2).toString();
              break;
          }
          CALCULATOR.CURRENT_NUMBER = CALCULATOR.OUTPUT;
          CALCULATOR.OPERAND = "";
        }
      } catch (e) {
        CALCULATOR.OUTPUT = 'Error';
        CALCULATOR.CURRENT_NUMBER = '';
      }
    });
  }

  void _setOperand(String operand) {
    if (CALCULATOR.CURRENT_NUMBER.isNotEmpty) {
      setState(() {
        CALCULATOR.CURRENT_NUMBER += " $operand ";
        CALCULATOR.OUTPUT = "0";
        CALCULATOR.OPERAND = operand;
      });
    }
  }

  void _appendToCurrentNumber(String digit) {
    setState(() {
      if (CALCULATOR.OUTPUT == "0") {
        CALCULATOR.OUTPUT = digit;
      } else {
        CALCULATOR.OUTPUT += digit;
      }
      CALCULATOR.CURRENT_NUMBER += digit;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.all(20),
            child: Text(
              CALCULATOR.CURRENT_NUMBER,
              style: TextStyle(fontSize: 48, color: Colors.grey),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              CALCULATOR.OUTPUT,
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton("7"),
              _buildButton("8"),
              _buildButton("9"),
              _buildButton("/"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton("4"),
              _buildButton("5"),
              _buildButton("6"),
              _buildButton("*"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton("1"),
              _buildButton("2"),
              _buildButton("3"),
              _buildButton("-"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton("C"),
              _buildButton("0"),
              _buildButton("="),
              _buildButton("+"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String buttonText) {
    return Container(
      margin: EdgeInsets.all(8),
      child: ElevatedButton(
        onPressed: () => _handleButtonPress(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
